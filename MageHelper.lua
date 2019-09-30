-- Author      : maui
-- Create Date : 9/30/2019 12:43:51 PM
SLASH_CMD1 = "/magehelper"
SLASH_CMD2 = "/mh"
SlashCmdList["CMD"] = function(msg)
   MageHelper_Show()
end 

MyKeywords = nil

function MageHelper_SetVars(self, event, addon)
	if addon ~= "MageHelper" then
		return -- not my addon
	else
		self:UnregisterEvent("ADDON_LOADED")
	
		DEFAULT_CHAT_FRAME:AddMessage("MageHelper by Maui loaded. Type /magehelper or /mh to get started,")

		if (MageHelper_Keywords == nil) then MageHelper_Keywords = "test";	end
		if (MageHelper_Whisper == nil) then MageHelper_Whisper = "test123";	end
	
		Keywords:SetText(MageHelper_Keywords)
		AutoWhisper:SetText(MageHelper_Whisper)

		if ( MageHelper_Keywords ~= nil ) then
			MyKeywords = { strsplit(" ", MageHelper_Keywords) }
		end
	end
end

TheBuffWhisperer = CreateFrame("Frame")
local frame = TheBuffWhisperer
frame:RegisterEvent("CHAT_MSG_WHISPER")
frame:SetScript("OnEvent", function(self, event, msg, sender, ...)
  if (event == "CHAT_MSG_WHISPER" and MyKeywords ~= nil) then
	found = false
	for idx, keyw in pairs(MyKeywords) do 
		if ( string.find(msg, keyw ) ) then
			found = true
		end
	end
  end
  --
  if ( found  ) then
		-- WHISPER BACK
		-- and sender ~= UnitName("player")
		if ( AutoWhisper:GetText() ~= nil ) then
			SendChatMessage(AutoWhisper:GetText(), "WHISPER", nil, sender);
		end
  end
end)

function MageHelper_Show()
	--Keywords:SetText(MageHelper_Keywords)
	--AutoWhisper:SetText(MageHelper_Whisper)
	MageHelper:Show() 
end

function MageHelper_Save()
	MageHelper_Keywords = Keywords:GetText()
	MageHelper_Whisper = AutoWhisper:GetText()
	print("Keywords:")
	print(Keywords:GetText())
	print("Auto-Response (whisper):")
	print(AutoWhisper:GetText())
	print("MageHelper -- Saved");
	MageHelper:Hide()
end
--local s = split(self:GetName(), "_")  --remove "_star" from last bit

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", MageHelper_SetVars)