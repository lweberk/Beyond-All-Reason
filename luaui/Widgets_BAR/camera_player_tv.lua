function widget:GetInfo()
	return {
		name		= "Player-TV",
		desc		= "Automaticly tracks players camera, (shows player-switch countdown on top of advplayerlist)",
		author		= "Floris",
		date		= "January 2018",
		license		= "GNU GPL, v2 or later",
		layer		= -2,
		enabled		= true,
	}
end

local fontfile = "fonts/" .. Spring.GetConfigString("bar_font", "Poppins-Regular.otf")
local vsx,vsy = Spring.GetViewGeometry()
local fontfileScale = (0.5 + (vsx*vsy / 5700000))
local fontfileSize = 36
local fontfileOutlineSize = 7
local fontfileOutlineStrength = 1.15
local font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
local fontfile2 = "fonts/" .. Spring.GetConfigString("bar_font2", "Exo2-SemiBold.otf")
local fontfileScale2 = fontfileScale * 2.75
local font2 = gl.LoadFont(fontfile2, fontfileSize*fontfileScale2, fontfileOutlineSize*fontfileScale2, fontfileOutlineStrength)

local displayPlayername = true

local playerChangeDelay = 40

local parentPos = {}
local prevPos = {}
local drawlistsCountdown = {}
local drawlistsPlayername = {}
local fontSize = 12	-- 14 to be alike with advplayerslist_lockcamera widget
local top, left, bottom, right, widgetScale = 0,0,0,0,1
local rejoining = false
local initGameframe = Spring.GetGameFrame()
local prevOrderID = 1

local currentTrackedPlayer
local playersTS = {}
local nextTrackingPlayerChange = os.clock()

local tsOrderedPlayerCount = 0
local tsOrderedPlayers = {}

local isSpec = Spring.GetSpectatingState()
local vsx, vsy = Spring.GetViewGeometry()
local widgetScale = (0.7 + (vsx*vsy / 5000000))

local toggled = false

local drawlist = {}
local widgetHeight = 22

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function addPlayerTsOrdered(ts, playerID, teamID, spec)
	local inserted = false
	local newTsOrderedPlayers = {}
	tsOrderedPlayerCount = 0
	for _,params in ipairs(tsOrderedPlayers) do
		if not inserted and ts > params[1] then
			tsOrderedPlayerCount = tsOrderedPlayerCount + 1
			newTsOrderedPlayers[tsOrderedPlayerCount] = {ts, playerID, teamID, spec}
			inserted = true
		end
		tsOrderedPlayerCount = tsOrderedPlayerCount + 1
		newTsOrderedPlayers[tsOrderedPlayerCount] = params
	end
	if not inserted then
		tsOrderedPlayerCount = tsOrderedPlayerCount + 1
		newTsOrderedPlayers[tsOrderedPlayerCount] = {ts, playerID, teamID, spec }
	end
	tsOrderedPlayers = deepcopy(newTsOrderedPlayers)
end

function tsOrderPlayers()
	local playersList = Spring.GetPlayerList()
	for _,playerID in ipairs(playersList) do
		local _,_,spec,teamID = Spring.GetPlayerInfo(playerID,false)
		if playersTS[playerID] ~= nil then
			addPlayerTsOrdered(playersTS[playerID], playerID, teamID, spec)
		end
	end
end

function GetSkill(playerID)
	local customtable = select(11,Spring.GetPlayerInfo(playerID)) -- player custom table
	local tsMu = customtable.skill
	local tskill = ""
	if tsMu then
		tskill = tsMu and tonumber(tsMu:match("%d+%.?%d*")) or 0
	end
	return tskill
end


function SelectTrackingPlayer(playerID)
	local newTrackedPlayer
	if playerID then
		newTrackedPlayer = playerID
	else
		local highestTs = 0
		local playersList = Spring.GetPlayerList()
		for _,playerID in ipairs(playersList) do
			local _,active,spec = Spring.GetPlayerInfo(playerID,false)
			if not spec and active then
				if playersTS[playerID] ~= nil and playersTS[playerID] > highestTs then
					highestTs = playersTS[playerID]
					newTrackedPlayer = playerID
				end
			end
		end
	end
	if newTrackedPlayer ~= nil and newTrackedPlayer ~= currentTrackedPlayer then
		currentTrackedPlayer = newTrackedPlayer

		if WG['advplayerlist_api'] ~= nil and WG['advplayerlist_api'].SetLockPlayerID ~= nil then
			WG['advplayerlist_api'].SetLockPlayerID(currentTrackedPlayer)
		end
	end
end

function createCountdownLists()
	--if parentPos ~= nil then
		for i=1,#drawlistsCountdown do
			gl.DeleteList(drawlistsCountdown[i])
		end
		drawlistsCountdown = {}
		local i = 0
		local leftPadding = 7.5*widgetScale
		while i < playerChangeDelay do
			drawlistsCountdown[i] = gl.CreateList(function()
				font:Begin()
				font:SetTextColor(0,0,0,0.6)
				font:Print(i, leftPadding+left-(0.7*widgetScale), bottom+(7*widgetScale), fontSize*widgetScale, 'n')
				font:Print(i, leftPadding+left+(0.7*widgetScale), bottom+(7*widgetScale), fontSize*widgetScale, 'n')
				font:SetTextColor(0.88,0.88,0.88,1)
				font:Print(i, leftPadding+left, bottom+(8*widgetScale), fontSize*widgetScale, 'n')
				font:End()
			end)
			i = i + 1
		end
	--end
end


local function DrawRectRound(px,py,sx,sy,cs, tl,tr,br,bl, c1,c2)
	local csyMult = 1 / ((sy-py)/cs)

	if c2 then
		gl.Color(c1[1],c1[2],c1[3],c1[4])
	end
	gl.Vertex(px+cs, py, 0)
	gl.Vertex(sx-cs, py, 0)
	if c2 then
		gl.Color(c2[1],c2[2],c2[3],c2[4])
	end
	gl.Vertex(sx-cs, sy, 0)
	gl.Vertex(px+cs, sy, 0)

	-- left side
	if c2 then
		gl.Color(c1[1]*(1-csyMult)+(c2[1]*csyMult),c1[2]*(1-csyMult)+(c2[2]*csyMult),c1[3]*(1-csyMult)+(c2[3]*csyMult),c1[4]*(1-csyMult)+(c2[4]*csyMult))
	end
	gl.Vertex(px, py+cs, 0)
	gl.Vertex(px+cs, py+cs, 0)
	if c2 then
		gl.Color(c2[1]*(1-csyMult)+(c1[1]*csyMult),c2[2]*(1-csyMult)+(c1[2]*csyMult),c2[3]*(1-csyMult)+(c1[3]*csyMult),c2[4]*(1-csyMult)+(c1[4]*csyMult))
	end
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)

	-- right side
	if c2 then
		gl.Color(c1[1]*(1-csyMult)+(c2[1]*csyMult),c1[2]*(1-csyMult)+(c2[2]*csyMult),c1[3]*(1-csyMult)+(c2[3]*csyMult),c1[4]*(1-csyMult)+(c2[4]*csyMult))
	end
	gl.Vertex(sx, py+cs, 0)
	gl.Vertex(sx-cs, py+cs, 0)
	if c2 then
		gl.Color(c2[1]*(1-csyMult)+(c1[1]*csyMult),c2[2]*(1-csyMult)+(c1[2]*csyMult),c2[3]*(1-csyMult)+(c1[3]*csyMult),c2[4]*(1-csyMult)+(c1[4]*csyMult))
	end
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)

	local offset = 0.15		-- texture offset, because else gaps could show

	-- bottom left
	if c2 then
		gl.Color(c1[1],c1[2],c1[3],c1[4])
	end
	if ((py <= 0 or px <= 0)  or (bl ~= nil and bl == 0)) and bl ~= 2   then
		gl.Vertex(px, py, 0)
	else
		gl.Vertex(px+cs, py, 0)
	end
	gl.Vertex(px+cs, py, 0)
	if c2 then
		gl.Color(c1[1]*(1-csyMult)+(c2[1]*csyMult),c1[2]*(1-csyMult)+(c2[2]*csyMult),c1[3]*(1-csyMult)+(c2[3]*csyMult),c1[4]*(1-csyMult)+(c2[4]*csyMult))
	end
	gl.Vertex(px+cs, py+cs, 0)
	gl.Vertex(px, py+cs, 0)
	-- bottom right
	if c2 then
		gl.Color(c1[1],c1[2],c1[3],c1[4])
	end
	if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2 then
		gl.Vertex(sx, py, 0)
	else
		gl.Vertex(sx-cs, py, 0)
	end
	gl.Vertex(sx-cs, py, 0)
	if c2 then
		gl.Color(c1[1]*(1-csyMult)+(c2[1]*csyMult),c1[2]*(1-csyMult)+(c2[2]*csyMult),c1[3]*(1-csyMult)+(c2[3]*csyMult),c1[4]*(1-csyMult)+(c2[4]*csyMult))
	end
	gl.Vertex(sx-cs, py+cs, 0)
	gl.Vertex(sx, py+cs, 0)
	-- top left
	if c2 then
		gl.Color(c2[1],c2[2],c2[3],c2[4])
	end
	if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2 then
		gl.Vertex(px, sy, 0)
	else
		gl.Vertex(px+cs, sy, 0)
	end
	gl.Vertex(px+cs, sy, 0)
	if c2 then
		gl.Color(c2[1]*(1-csyMult)+(c1[1]*csyMult),c2[2]*(1-csyMult)+(c1[2]*csyMult),c2[3]*(1-csyMult)+(c1[3]*csyMult),c2[4]*(1-csyMult)+(c1[4]*csyMult))
	end
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)
	-- top right
	if c2 then
		gl.Color(c2[1],c2[2],c2[3],c2[4])
	end
	if ((sy >= vsy or sx >= vsx)  or (tr ~= nil and tr == 0)) and tr ~= 2 then
		gl.Vertex(sx, sy, 0)
	else
		gl.Vertex(sx-cs, sy, 0)
	end
	gl.Vertex(sx-cs, sy, 0)
	if c2 then
		gl.Color(c2[1]*(1-csyMult)+(c1[1]*csyMult),c2[2]*(1-csyMult)+(c1[2]*csyMult),c2[3]*(1-csyMult)+(c1[3]*csyMult),c2[4]*(1-csyMult)+(c1[4]*csyMult))
	end
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)
end
function RectRound(px,py,sx,sy,cs, tl,tr,br,bl, c1,c2)		-- (coordinates work differently than the RectRound func in other widgets)
	gl.Texture(false)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs, tl,tr,br,bl, c1,c2)
end

local function createList()
	for i=1,#drawlist do
		gl.DeleteList(drawlist[i])
	end
	drawlist = {}
	drawlist[1] = gl.CreateList( function()
		local fontSize = (widgetHeight*widgetScale) * 0.5
		local text = '   cancel camera   '
		local color = '\255\255\222\222'
		local color1, color2
		if not toggled and not lockPlayerID then
			text = '   Player TV   '
			color = '\255\222\255\222'
			color1 = {0, 0.8, 0, 0.66}
			color2 = {0, 0.55, 0, 0.66}
		else
			color1 = {0.88, 0.1, 0.1, 0.66}
			color2 = {0.6, 0.05, 0.05, 0.66}
		end
		local textWidth = font:GetTextWidth(text) * fontSize
		RectRound(right-textWidth, bottom, right, top, 4*widgetScale, 1,1,1,1, color1, color2)
		toggleButton = {right-textWidth, bottom, right, top }

		local borderPadding = 2.25*widgetScale
		RectRound(right-textWidth+borderPadding, bottom, right-borderPadding, top-borderPadding, 2.5*widgetScale, 1,1,1,1, {0.3,0.3,0.3,0.25}, {0.05,0.05,0.05,0.25})

		font:Begin()
        font:Print(color..text, right-(textWidth/2), bottom+(8*widgetScale), fontSize, 'oc')

		if toggled then
			local name = 'Player TV  '
			local fontSize = (widgetHeight*widgetScale) * 0.6
			local vpos = bottom+(5.5*widgetScale)
			font:SetTextColor(0,0,0,0.6)
			font:Print(name, right-textWidth-(0.7*widgetScale), vpos, fontSize, 'rn')
			font:Print(name, right-textWidth+(0.7*widgetScale), vpos, fontSize, 'rn')
			font:SetTextColor(1,1,1,1)
			font:Print(name, right-textWidth, vpos+(1*widgetScale), fontSize, 'rn')
		end
		font:End()
	end)
	drawlist[2] = gl.CreateList( function()
		if toggled or lockPlayerID  then
			gl.Color(1, 0.2, 0.2, 0.4)
		else
			gl.Color(0.2, 1, 0.2, 0.4)
		end
		RectRound(toggleButton[1], toggleButton[2], toggleButton[3], toggleButton[4], 4.5*widgetScale)

		local borderPadding = 2.75*widgetScale
		gl.Color(0,0,0,0.14)
		RectRound(toggleButton[1]+borderPadding, toggleButton[2]+borderPadding, toggleButton[3]-borderPadding, toggleButton[4]-borderPadding, 3.6*widgetScale)

		local text = '   cancel camera   '
		local color = '\255\255\225\225'
		if not toggled and not lockPlayerID then
			text = '   Player TV   '
			color = '\255\225\255\225'
		end
		local fontSize = (widgetHeight*widgetScale) * 0.5
		local textWidth = font:GetTextWidth(text) * fontSize
		font:Begin()
		font:Print(color..text, toggleButton[3]-(textWidth/2), toggleButton[2]+(8*widgetScale), fontSize, 'oc')
		font:End()
	end)

	if WG['guishader'] and isSpec then
		if backgroundGuishader then
			backgroundGuishader = gl.DeleteList(backgroundGuishader)
		end
		backgroundGuishader = gl.CreateList( function()
			RectRound(toggleButton[1], toggleButton[2], toggleButton[3], toggleButton[4], 5.5*widgetScale)
		end)
		WG['guishader'].InsertDlist(backgroundGuishader, 'playertv')
	end
end



function updatePosition(force)
	local prevPos = parentPos
	if WG['displayinfo'] ~= nil then
		parentPos = WG['displayinfo'].GetPosition()		-- returns {top,left,bottom,right,widgetScale}
	elseif WG['unittotals'] ~= nil then
		parentPos = WG['unittotals'].GetPosition()		-- returns {top,left,bottom,right,widgetScale}
	elseif WG['music'] ~= nil then
		parentPos = WG['music'].GetPosition()		-- returns {top,left,bottom,right,widgetScale}
	elseif WG['advplayerlist_api'] ~= nil then
		parentPos = WG['advplayerlist_api'].GetPosition()		-- returns {top,left,bottom,right,widgetScale}
	end
	if parentPos[5] ~= nil then
		left = parentPos[2]
		bottom = parentPos[1]
		right = parentPos[4]
		top = parentPos[1]+(widgetHeight*parentPos[5])
		widgetScale = parentPos[5]

		if (prevPos[1] == nil or prevPos[1] ~= parentPos[1] or prevPos[2] ~= parentPos[2] or prevPos[5] ~= parentPos[5]) or force then
			createCountdownLists()
			createList()
		end
	end
end


function widget:Initialize()
	isSpec = Spring.GetSpectatingState()
	if WG['advplayerlist_api'] == nil then
		Spring.Echo("Top TS camera tracker: AdvPlayerlist not found! ...exiting")
		widgetHandler:RemoveWidget(self)
		return
    end

    local humanPlayers = 0
	local playersList = Spring.GetPlayerList()
	for _,playerID in ipairs(playersList) do
		local _,active,spec,team = Spring.GetPlayerInfo(playerID,false)
		if not spec then
			playersTS[playerID] = GetSkill(playerID)
            if not select(3,Spring.GetTeamInfo(team,false)) and not select(4,Spring.GetTeamInfo(team,false)) then
                humanPlayers = humanPlayers + 1
            end
		end
    end
    if humanPlayers == 0 then
        widgetHandler:RemoveWidget(self)
		return
    end

	tsOrderPlayers()

	updatePosition()
	WG['playertv'] = {}
	WG['playertv'].GetPosition = function()
		return {top,left,bottom,right,widgetScale}
	end
	WG['playertv'].isActive = function()
		return (toggled and isSpec)
	end
	WG['playertv'].GetPlayerChangeDelay = function()
		return playerChangeDelay
	end
	WG['playertv'].SetPlayerChangeDelay = function(value)
		playerChangeDelay = value
		createCountdownLists()
	end
end


function widget:GameStart()
	isSpec = Spring.GetSpectatingState()
	nextTrackingPlayerChange = os.clock()
	tsOrderPlayers()
	if isSpec and not rejoining and toggled then
		SelectTrackingPlayer()
	end
end


function widget:PlayerChanged(playerID)
	isSpec = Spring.GetSpectatingState()
	tsOrderPlayers()
	if not rejoining then
		if playerID == currentTrackedPlayer then
			SelectTrackingPlayer()
		end
	end
end

local passedTime = 1
function widget:Update(dt)
	passedTime = passedTime + dt
	if passedTime > 0.1 then
		passedTime = 0
		updatePosition()
	end
	if isSpec and Spring.GetGameFrame() > 0 and not rejoining then
		if WG['tooltip'] and not toggled and not lockPlayerID then
			mx,my,mb = Spring.GetMouseState()
			if toggleButton ~= nil and isInBox(mx, my, toggleButton) then
				WG['tooltip'].ShowTooltip('playertv', 'Auto camera-track of mostly top TS players\n(switches player every '..playerChangeDelay..' seconds)')
			end
		end
		if (not rejoining and toggled) then
			if Spring.GetGameFrame() > initGameframe+70 and os.clock() > nextTrackingPlayerChange then	--delay some gameframes so we know if we're rejoining or not
				nextTrackingPlayerChange = os.clock() + playerChangeDelay
				local scope = 1 + math.floor(1 + tsOrderedPlayerCount/2)
				if tsOrderedPlayerCount <= 2 then
					scope = 2
				elseif tsOrderedPlayerCount <= 6 then
					scope = 1 + math.floor(1 + tsOrderedPlayerCount/1.5)
				elseif tsOrderedPlayerCount <= 10 then
					scope = 1 + math.floor(1 + tsOrderedPlayerCount/1.75)
				end
				local orderID = math.random(1,scope)

				local r = math.random()
				orderID = 1 + math.floor((r * (r*r)) * scope)
				if orderID == prevOrderID then	-- prevent same player POV again
					orderID = orderID - 1
					if orderID < 1 then
						orderID = 2
					end
				end
				prevorderID = orderID
				if tsOrderedPlayers[orderID] then
					SelectTrackingPlayer(tsOrderedPlayers[orderID][2])
				end
			end
		end
	end
end

function widget:GameFrame(n)
	if WG['topbar'] then
		local prevRejoining = rejoining
		rejoining = WG['topbar'].showingRejoining()
	end
	if isSpec and toggled and n % 30 == 5 then
		if rejoining and prevRejoining ~= rejoining then
			SelectTrackingPlayer()
		elseif rejoining and WG['advplayerlist_api'] and WG['advplayerlist_api'].GetLockPlayerID() ~= nil then
			WG['advplayerlist_api'].SetLockPlayerID()
		end
		prevGameframeClock = os.clock()

		if currentTrackedPlayer ~= nil and not rejoining then
			local _,active,spec = Spring.GetPlayerInfo(currentTrackedPlayer,false)
			if not active or spec then
				SelectTrackingPlayer()
			end
		end
	end
end

function isInBox(mx, my, box)
    if (WG['topbar'] and WG['topbar'].showingQuit()) then
        return false
    else
	    return mx > box[1] and my > box[2] and mx < box[3] and my < box[4]
    end
end

function widget:MousePress(mx, my, mb)
	if isSpec and mb == 1 and (Spring.GetGameFrame() > 0 or lockPlayerID) then
		if toggleButton ~= nil and isInBox(mx, my, toggleButton) then
			prevorderID = nil
			currentTrackedPlayer = nil
			if toggled or lockPlayerID then
				toggled = false
				if WG['advplayerlist_api'] then
					WG['advplayerlist_api'].SetLockPlayerID()
				end
				lockPlayerID = nil
				prevLockPlayerID = nil
				createList()
			elseif not rejoining then
				toggled = true
				nextTrackingPlayerChange = os.clock()-1
				createList()
			end
		end
	end
end

function widget:ViewResize(newX,newY)
	vsx, vsy = Spring.GetViewGeometry()
	widgetScale = (0.7 + (vsx*vsy / 5000000))

	local newFontfileScale = (0.5 + (vsx*vsy / 5700000))
	if (fontfileScale ~= newFontfileScale) then
		fontfileScale = newFontfileScale
		gl.DeleteFont(font)
		font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
		gl.DeleteFont(font2)
		font2 = gl.LoadFont(fontfile2, fontfileSize*fontfileScale2, fontfileOutlineSize*fontfileScale2, fontfileOutlineStrength)

		for i=1,#drawlistsCountdown do
			gl.DeleteList(drawlistsCountdown[i])
		end
		for i,v in pairs(drawlistsPlayername) do
			gl.DeleteList(drawlistsPlayername[i])
		end
		drawlistsCountdown = {}
		drawlistsPlayername = {}
		if WG['guishader'] and backgroundGuishader then
			WG['guishader'].DeleteDlist('playertv')
			backgroundGuishader = nil
		end
		for i=1,#drawlist do
			drawlist[i] = gl.DeleteList(drawlist[i])
		end
	end
	createCountdownLists()
end



function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
	end
end

function widget:DrawScreen()
	if chobbyInterface then return end
	if not isSpec then return end

	local gameFrame = Spring.GetGameFrame()

	if (rejoining or gameFrame == 0) and not lockPlayerID then
		if WG['guishader'] then
			WG['guishader'].RemoveDlist('playertv')
		end
		--return
	end

	if gameFrame > 0 or lockPlayerID then
		if drawlist[1] then
			gl.PushMatrix()
			gl.CallList(drawlist[1])
			gl.PopMatrix()
			mx,my,mb = Spring.GetMouseState()
			if toggleButton ~= nil and isInBox(mx, my, toggleButton) then
				gl.CallList(drawlist[2])
			end
		end
	end

	if toggled and not rejoining and gameFrame > 0 then
		local countDown = math.floor(nextTrackingPlayerChange - os.clock())
		if drawlistsCountdown[countDown] ~= nil then
			gl.PushMatrix()
			gl.CallList(drawlistsCountdown[countDown])
			gl.PopMatrix()
		end
	end
	if displayPlayername then
		if WG['advplayerlist_api'] then
			if lockPlayerID == nil or lockPlayerID ~= WG['advplayerlist_api'].GetLockPlayerID() then
				lockPlayerID = WG['advplayerlist_api'].GetLockPlayerID()
				if not toggled and prevLockPlayerID ~= lockPlayerID then
					createList()
					prevLockPlayerID = lockPlayerID
				end
				if lockPlayerID and not drawlistsPlayername[lockPlayerID] then
					drawlistsPlayername[lockPlayerID] = gl.CreateList( function()
						local name,_,spec,teamID,_,_,_,_,_ = Spring.GetPlayerInfo(lockPlayerID,false)
						local fontSize = 31 * widgetScale
						local nameColourR,nameColourG,nameColourB = 1,1,1
						if not spec then
							nameColourR,nameColourG,nameColourB,_ = Spring.GetTeamColor(teamID)
						end
						local posX = vsx * 0.5
						local posY = vsy * 0.095

						font2:Begin()
						font2:SetTextColor(nameColourR,nameColourG,nameColourB,1)
						if (nameColourR + nameColourG*1.2 + nameColourB*0.4) < 0.8 then
							font2:SetOutlineColor(1,1,1,1)
						else
							font2:SetOutlineColor(0,0,0,1)
						end
						font2:Print(name, posX, posY, fontSize, "con")
						font2:End()
					end)
				end
			end
		end
		if lockPlayerID and drawlistsPlayername[lockPlayerID] then
			gl.PushMatrix()
			gl.CallList(drawlistsPlayername[lockPlayerID])
			gl.PopMatrix()
		end
	end
end


function widget:Shutdown()
	for i=1,#drawlistsCountdown do
		gl.DeleteList(drawlistsCountdown[i])
	end
	for i,v in pairs(drawlistsPlayername) do
		gl.DeleteList(drawlistsPlayername[i])
	end
	drawlistsCountdown = {}
	drawlistsPlayername = {}
	if WG['guishader'] then
		WG['guishader'].DeleteDlist('playertv')
	end
	for i=1,#drawlist do
		gl.DeleteList(drawlist[i])
	end
	drawlist = {}
	gl.DeleteFont(font)
	gl.DeleteFont(font2)
	if toggled and WG['advplayerlist_api'] then
		WG['advplayerlist_api'].SetLockPlayerID()
	end
end


function widget:GetConfigData(data)
	savedTable = {}
	savedTable.toggled = toggled
	savedTable.playerChangeDelay = playerChangeDelay
	return savedTable
end

function widget:SetConfigData(data)
	if Spring.GetGameFrame() > 0 and data.toggled ~= nil then
		toggled = data.toggled
	end
	if data.playerChangeDelay then
		playerChangeDelay = data.playerChangeDelay
	end
end