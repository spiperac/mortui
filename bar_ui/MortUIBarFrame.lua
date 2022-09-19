-- mortUI v2.0 --
local _, Addon, mortui_settings = ...;

--------------------------------------------------------------------------------------------------
-- Global variables
--------------------------------------------------------------------------------------------------

BINDING_HEADER_MORTUIBAR = "mortUIBar";


--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

local mortUIBarVisibleBar;


--------------------------------------------------------------------------------------------------
-- Event functions
--------------------------------------------------------------------------------------------------

-- OnLoad Event
function mortUIBarFrame_OnLoad(self)

	-- Register the events that need to be watched
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	
end

-- OnEvent Event
function mortUIBarFrame_OnEvent(self, event, ...)

	if (event == "ADDON_LOADED") then
		local addonName = ...;
		if (addonName == "MortUI") then
			-- Initialize the addon
			mortUIBarFrame_Initialize();
		end
		return;
	elseif (event == "PLAYER_ENTERING_WORLD") then
		-- Display the Action Bar
		mortUIBarFrame_ShowBar("Action");
		return;
	end

end


--------------------------------------------------------------------------------------------------
-- Initialize functions
--------------------------------------------------------------------------------------------------

-- Initialize the addon
function mortUIBarFrame_Initialize()

	-- Set the new size
	MainMenuBar:SetWidth(512);
	MainMenuBarLeftEndCap:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", -288, 0);
	MainMenuBarRightEndCap:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", 288, 0);
	
	-- Initialize the XP bar
	MainMenuExpBar:SetWidth(512);
	MainMenuXPBarTexture0:SetPoint("BOTTOM", MainMenuExpBar, "BOTTOM", -128, 3);
	MainMenuXPBarTexture1:SetPoint("BOTTOM", MainMenuExpBar, "BOTTOM", 128, 3);
	MainMenuXPBarTexture2:Hide();
	MainMenuXPBarTexture3:Hide();
	
	-- Initialize the max level bar
	MainMenuBarMaxLevelBar:SetWidth(512);
	MainMenuMaxLevelBar0:SetPoint("BOTTOM", MainMenuBarMaxLevelBar, "BOTTOM", -128, 7);
	MainMenuMaxLevelBar1:SetPoint("BOTTOM", MainMenuBarMaxLevelBar, "BOTTOM", 128, 7);
	MainMenuMaxLevelBar2:Hide();
	MainMenuMaxLevelBar3:Hide();

	-- Hide Objective Trackers
	WatchFrame:Hide();
	
	-- Hide Gryphons
	MainMenuBarLeftEndCap:Hide();
	MainMenuBarRightEndCap:Hide();
	
	-- Initialize the reputation bar
	ReputationWatchBar:SetWidth(512);
	ReputationWatchStatusBar:SetWidth(512);
	ReputationWatchBarTexture2:SetTexture("");
	ReputationWatchBarTexture3:SetTexture("");
	ReputationXPBarTexture2:SetTexture("");
	ReputationXPBarTexture3:SetTexture("");
	
	-- Initialize the Action bar
	BonusActionButton1:SetPoint("BOTTOMLEFT", BonusActionBarFrame, "BOTTOMLEFT", 4, 3);
	MultiBarBottomLeft:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", -256, 18);
	
	-- Initialize the Micro bar
	ActionBarUpButton:ClearAllPoints();
	ActionBarDownButton:ClearAllPoints();
	
	-- Hook functions
	hooksecurefunc("VehicleMenuBar_MoveMicroButtons", mortUIVehicleMenuBar_MoveMicroButtons);

end


--------------------------------------------------------------------------------------------------
-- Display functions
--------------------------------------------------------------------------------------------------

-- Show the bar
function mortUIBarFrame_ShowBar(bar)

	-- Check the bar
	if (bar == "Action") then
		MainMenuBarTexture0:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", -128, 0);
		MainMenuBarTexture1:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", 128, 0);
		MainMenuBarTexture2:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", -128, -500);
		MainMenuBarTexture3:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", 128, -500);
		ActionButton1:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 8, 3);
		BonusActionBarFrame:SetPoint("TOPLEFT", BonusActionBarFrame:GetParent(), "BOTTOMLEFT", BONUSACTIONBAR_XPOS, BONUSACTIONBAR_YPOS);
		MainMenuBarPageNumber:SetPoint("CENTER", MainMenuBarArtFrame, "CENTER", -226, -505);
		ActionBarUpButton:SetPoint("CENTER", MainMenuBarArtFrame, "BOTTOMLEFT", 10, -530);
		ActionBarDownButton:SetPoint("CENTER", MainMenuBarArtFrame, "BOTTOMLEFT", 10, -511);
		CharacterMicroButton:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 40, -502);
		MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", MainMenuBarArtFrame, "BOTTOMRIGHT", -6, -502);
	elseif (bar == "Menu") then
		MainMenuBarTexture0:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", -128, -500);
		MainMenuBarTexture1:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", 128, -500);
		MainMenuBarTexture2:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", -128, 0);
		MainMenuBarTexture3:SetPoint("BOTTOM", MainMenuBarArtFrame, "BOTTOM", 128, 0);
		ActionButton1:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 8, -503);
		BonusActionBarFrame:SetPoint("TOPLEFT", BonusActionBarFrame:GetParent(), "BOTTOMLEFT", BONUSACTIONBAR_XPOS, -500);
		MainMenuBarPageNumber:SetPoint("CENTER", MainMenuBarArtFrame, "CENTER", -226, -5);
		ActionBarUpButton:SetPoint("CENTER", MainMenuBarArtFrame, "BOTTOMLEFT", 10, 30);
		ActionBarDownButton:SetPoint("CENTER", MainMenuBarArtFrame, "BOTTOMLEFT", 10, 11);
		CharacterMicroButton:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 40, 2);
		MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", MainMenuBarArtFrame, "BOTTOMRIGHT", -6, 2);
	end
	
	mortUIBarVisibleBar = bar;

end

-- Toggle the Main Bar
function mortUIBarFrame_Toggle()

	-- Check if toggle is safe
	if (not MainMenuBar.busy and not UnitHasVehicleUI("player") and not InCombatLockdown()) then
		-- Check the visible bar
		if (mortUIBarVisibleBar == "Action") then
			mortUIBarFrame_ShowBar("Menu");
		else
			mortUIBarFrame_ShowBar("Action");
		end
	end

end

function mortUIVehicleMenuBar_MoveMicroButtons(skinName)

	if (not skinName) then
		mortUIBarFrame_ShowBar(mortUIBarVisibleBar);
	end

end
