
Megaphone = {}

local playerFilter
local chatFilter = {}
local dafont

function Megaphone.Initialize()
	
	
	RegisterEventHandler(SystemData.Events.CHAT_TEXT_ARRIVED, "Megaphone.Filter");
	RegisterEventHandler(SystemData.Events.GROUP_UPDATED, "Megaphone.GroupUpdate");
	RegisterEventHandler(SystemData.Events.BATTLEGROUP_UPDATED, "Megaphone.GroupUpdate");
	RegisterEventHandler(SystemData.Events.GROUP_LEAVE, "Megaphone.Clear");
	RegisterEventHandler(SystemData.Events.INTERFACE_RELOADED, "Megaphone.GroupUpdate");
	
	if not Megaphone.Font then Megaphone.Font = 14 end
	if not Megaphone.Name then Megaphone.Name = 1 end
	Megaphone.SetFont();
	
	
	
	RegisterEventHandler(SystemData.Events.GROUP_PLAYER_ADDED, "Megaphone.GroupPlayerAdd");
	
  --register slash commands
    if LibSlash then
	--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"trying to reg")
		LibSlash.RegisterSlashCmd("megaphone", function(input) Megaphone.Showcommands(input) end)
		LibSlash.RegisterSlashCmd("mp", function(input) Megaphone.Showcommands(input) end)
        LibSlash.RegisterSlashCmd("megaphoneset", function(input) Megaphone.SlashHandler(input) end)
		LibSlash.RegisterSlashCmd("mpset", function(input) Megaphone.SlashHandler(input) end)
		LibSlash.RegisterSlashCmd("mpfl", function(input) Megaphone.findLeader(input) end)
		LibSlash.RegisterSlashCmd("mpcl", function(input) Megaphone.Clear(input) end)
		--LibSlash.RegisterSlashCmd("mpsl", function(input) Megaphone.Showleader(input) end)
		LibSlash.RegisterSlashCmd("mpfont", function(input) Megaphone.GetFont(input) end)
		LibSlash.RegisterSlashCmd("mps", function(input) Megaphone.ShowFont(input) end)
		LibSlash.RegisterSlashCmd("mpshow", function(input) Megaphone.ShowFonts(input) end)
		LibSlash.RegisterSlashCmd("mphide", function(input) Megaphone.Hidename(input) end)
		
		
	
		
		
		
		
    end    
    TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus v2.0 ready. Type /mp for available commands.")
end

function Megaphone.Hidename()

	
	if Megaphone.Name == 1 then
		Megaphone.Name = 0
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Show leader's name disabled")
	else 
		Megaphone.Name = 1
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Show leader's name enabled")
	end
	
	 

end


function Megaphone.SetFont()
		if Megaphone.Font == 1 then
			dafont = SystemData.AlertText.Types.STATUS_ACHIEVEMENTS_GOLD
		elseif Megaphone.Font == 2 then
			dafont = SystemData.AlertText.Types.STATUS_ERRORS
		elseif Megaphone.Font == 3 then 
			dafont = SystemData.AlertText.Types.PQ_NAME
		elseif Megaphone.Font == 4 then
			dafont = SystemData.AlertText.Types.QUEST_NAME
		elseif Megaphone.Font == 5 then
			dafont = SystemData.AlertText.Types.RVR
		elseif Megaphone.Font == 6 then
			dafont = SystemData.AlertText.Types.GUILD_RANK
		elseif Megaphone.Font == 7 then
			dafont = SystemData.AlertText.Types.PQ_DESCRIPTION
		elseif Megaphone.Font == 8 then
			dafont = SystemData.AlertText.Types.ORDER
		elseif Megaphone.Font == 9 then
			dafont = SystemData.AlertText.Types.STATUS_ACHIEVEMENTS_RANK
		elseif Megaphone.Font == 10 then
			dafont = SystemData.AlertText.Types.CITY_RATING
		elseif Megaphone.Font == 11 then
			dafont = SystemData.AlertText.Types.OBJECTIVE
		elseif Megaphone.Font == 12 then
			dafont = SystemData.AlertText.Types.NEUTRAL
		elseif Megaphone.Font == 13 then
			dafont = SystemData.AlertText.Types.SCENARIO
		elseif Megaphone.Font == 14 then
			dafont = SystemData.AlertText.Types.QUEST_END
		elseif Megaphone.Font == 15 then
			dafont = SystemData.AlertText.Types.DEFAULT
		elseif Megaphone.Font == 16 then
			dafont = SystemData.AlertText.Types.ABILITY
		elseif Megaphone.Font == 17 then
			dafont = SystemData.AlertText.Types.BO_NAME
		elseif Megaphone.Font == 18 then
			dafont = SystemData.AlertText.Types.ENTERZONE
		elseif Megaphone.Font == 19 then
			dafont = SystemData.AlertText.Types.QUEST_CONDITION
		elseif Megaphone.Font == 20 then
			dafont = SystemData.AlertText.Types.STATUS_ACHIEVEMENTS_PURPLE
		elseif Megaphone.Font == 21 then
			dafont = SystemData.AlertText.Types.MOVEMENT_RVR
		elseif Megaphone.Font == 22 then
			dafont = SystemData.AlertText.Types.COMBAT
		elseif Megaphone.Font == 23 then
			dafont = SystemData.AlertText.Types.BO_DESCRIPTION
		elseif Megaphone.Font == 24 then
			dafont = SystemData.AlertText.Types.DESTRUCTION
		elseif Megaphone.Font == 25 then
			dafont = SystemData.AlertText.Types.ENTERAREA
		elseif Megaphone.Font == 26 then
			dafont = SystemData.AlertText.Types.STATUS_ACHIEVEMENTS_RENOUN
		else 
			dafont = SystemData.AlertText.Types.QUEST_END
		end
			
	
	
	

end

function Megaphone.SlashHandler(args)
  local opt, opt2, opt3, val, val2, val3
  local ttable, option
  opt, val = args:match("(%w+)[ ]?(.*)")

  if opt then
    playerFilter = WStringToString(opt)
	
    TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: set leader=[" .. playerFilter .. L"]")
  else
    TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"/MegaphonePlus playername");
  end
end

function Megaphone.ShowFonts()
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"======================================")
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: The available fonts are:");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F1 or STATUS_ACHIEVEMENTS_GOLD]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F2 or STATUS_ERRORS]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F3 or PQ_NAME]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F4 or QUEST_NAME]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F5 or RVR]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F6 or GUILD_RANK]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F7 or PQ_DESCRIPTION]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F8 or ORDER]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F9 or STATUS_ACHIEVEMENTS_RANK]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F10 or CITY_RATING]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F11 or OBJECTIVE]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F12 or NEUTRAL]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F13 or SCENARIO]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F14 or QUEST_END]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F15 or DEFAULT]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F16 or ABILITY]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F17 or BO_NAME]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F18 or ENTERZONE]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F19 or QUEST_CONDITION]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F20 or STATUS_ACHIEVEMENTS_PURPLE]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F21 or MOVEMENT_RVR]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F22 or COMBAT]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F23 or BO_DESCRIPTION]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F24 or DESTRUCTION]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F25 or ENTERAREA]");
 TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"[F26 or STATUS_ACHIEVEMENTS_RENOUN]");
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"======================================")


end

function Megaphone.GetFont(args)
  local opt, opt2, opt3, val, val2, val3
  local ttable, option
  opt, val = args
  
	if (opt:upper() == "F1" or opt:upper() =="STATUS_ACHIEVEMENTS_GOLD") then
		Megaphone.Font = 1
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F2" or opt:upper() == "STATUS_ERRORS") then
		Megaphone.Font = 2
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F3" or opt:upper() == "PQ_NAME") then
		Megaphone.Font = 3
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F4" or opt:upper() == "QUEST_NAME") then
		Megaphone.Font = 4
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F5" or opt:upper() == "RVR") then
		Megaphone.Font = 5
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F6" or opt:upper() == "GUILD_RANK") then
		Megaphone.Font = 6
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F7" or opt:upper() == "PQ_DESCRIPTION") then
		Megaphone.Font = 7
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F8" or opt:upper() == "ORDER") then
		Megaphone.Font = 8
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F9" or opt:upper() == "STATUS_ACHIEVEMENTS_RANK") then
		Megaphone.Font = 9
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F10" or opt:upper() == "CITY_RATING") then
		Megaphone.Font = 10
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F11" or opt:upper() == "OBJECTIVE") then
		Megaphone.Font = 11
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F12" or opt:upper() == "NEUTRAL") then
		Megaphone.Font = 12
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F13" or opt:upper() == "SCENARIO") then
		Megaphone.Font = 13
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F14" or opt:upper() == "QUEST_END") then
		Megaphone.Font = 14
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F15" or opt:upper() == "DEFAULT") then
		Megaphone.Font = 15
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F16" or opt:upper() == "ABILITY") then
		Megaphone.Font = 16
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F17" or opt:upper() == "BO_NAME") then
		Megaphone.Font = 17
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F18" or opt:upper() == "ENTERZONE") then
		Megaphone.Font = 18
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F19" or opt:upper() == "QUEST_CONDITION") then
		Megaphone.Font = 19
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F20" or opt:upper() == "STATUS_ACHIEVEMENTS_PURPLE") then
		Megaphone.Font = 20
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F21" or opt:upper() == "MOVEMENT_RVR") then
		Megaphone.Font = 21
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F22" or opt:upper() == "COMBAT") then
		Megaphone.Font = 22
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F23" or opt:upper() == "BO_DESCRIPTION") then
		Megaphone.Font = 23
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F24" or opt:upper() == "DESTRUCTION") then
		Megaphone.Font = 24
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F25" or opt:upper() == "ENTERAREA") then
		Megaphone.Font = 25
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	elseif (opt:upper() == "F26" or opt:upper() == "STATUS_ACHIEVEMENTS_RENOUN") then
		Megaphone.Font = 26
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font set to =[" .. StringToWString(opt) .. L"]")
	else 
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Enter a font code or name. /mpshow for more info.")
	end
  
  Megaphone.SetFont();
end

function Megaphone.Showleader()
	if (playerFilter == nill or playerFilter == Megaphone.prepPlayerName("x")) then
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: No leader selected.")
	else 
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Current leader=[" .. playerFilter .. L"]")
	end
end

function Megaphone.Clear()
playerFilter=Megaphone.prepPlayerName("x");
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Cleared Leader.");
end

function Megaphone.ShowFont()

TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Font=[F" .. Megaphone.Font .. L"]");
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Show name=[" .. Megaphone.Name .. L"]");
	if (playerFilter == nill or playerFilter == Megaphone.prepPlayerName("x")) then
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: No leader selected.")
	else 
		TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: Current leader=[" .. playerFilter .. L"]")
	end

end

function Megaphone.Showcommands()
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"==========================================")
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"/mpshow to see a list of available fonts.")
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"/mpfont font_name to set the desired font.")
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"/mphide to toggle show leader's name.")
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"/mps to show current settings.")
TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"==========================================")

end

function Megaphone.GroupPlayerAdd()
    --TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: GroupPlayerAdd")
	Megaphone.findLeader();
end

function Megaphone.GroupUpdate()
	--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: GroupUpdate")
	Megaphone.findLeader();
end


function Megaphone.findLeader()

	local leader;
	local player;
	local isGL;
	local lastKnownLeader = playerFilter;
	playerFilter = nil;
    local groups = GetBattlegroupMemberData();
	--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: group ")
    for group = 1, #groups do
      members = groups[group].players;
     -- TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: group " .. group .. L" has " .. #members .. L" members")
      for member= 1, #members do
         player = members[member];
        -- if player.isInSameRegion and player.isGroupLeader then
		if player.isGroupLeader then
           leader = player.name;
           playerFilter = Megaphone.prepPlayerName(leader)
           --TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: found leader [" .. player.name .. L"]")
           --break;
         else
           --TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: member [" .. player.name .. L"]")
         end
      end
    end
    if (playerFilter == nil) then
        playerFilter=lastKnownLeader;
    end
    if (playerFilter ~= lastKnownLeader) then
        TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"MegaphonePlus: found new leader=[" .. playerFilter .. L"]")
		
    end
end



function Megaphone.Filter()

	local chatType = GameData.ChatData.type
	local chatSender = Megaphone.prepPlayerName(GameData.ChatData.name)
	local chatText = GameData.ChatData.text:lower()
	local chattype2 = GameData.ChatData.type
	
	
	--AlertTextWindow.AddLine(SystemData.AlertText.Types.MOVEMENT_RVR, chatSender .. L": " .. chatText);
	--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L" TYPE '" .. chattype)
	--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: chat added to warband" .. chatText)
	--if IsWarBandActive() then
	--if (chattype2 == 4 or chattype2 == 14) then
    --if (string.find(WStringToString(chatText), "added to the warband",1,1)) then
	   -- TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L"Megaphone: chat added to warband")
	--	Megaphone.findLeader();
		--return;
	--end
	--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, chatSender .. L": " .. playerFilter)
	if chatSender == playerFilter then 
	
    	if chatType == SystemData.ChatLogFilters.GROUP or
	      chatType == SystemData.ChatLogFilters.BATTLEGROUP or
		  --chatType == SystemData.ChatLogFilters.SHOUT or
		  --chatType == SystemData.ChatLogFilters.SAY or
		  chatType == SystemData.ChatLogFilters.SCENARIO_GROUPS then
		    -- Do Alert Message here...
		    PlaySound(GameData.Sound.QUEST_COMPLETED);
			if Megaphone.Name == 1 then
				AlertTextWindow.AddLine(dafont, chatSender .. L": " .. chatText);
			else 
				AlertTextWindow.AddLine(dafont, chatText);
			end
			
			--TextLogAddEntry("Chat", SystemData.ChatLogFilters.TELL_RECEIVE, L" MEGAPHONE: '" .. playerFilter .. L"' " .. chatText)
		  end
	end

end

function Megaphone.prepPlayerName(name)
	-- Inspired by a function by Skoli, author of SKNotice.
	local playerName = name:lower()
	if(type(playerName) == "wstring") then
		playerName =  WStringToString(playerName):match("([^^]+)^?([^^]*)")
	elseif(type(playerName) == "string") then
		playerName = playerName:match("([^^]+)^?([^^]*)")
	end
	playerName = towstring(playerName)
	return playerName
end
