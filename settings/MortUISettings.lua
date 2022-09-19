-- Add main Interface Option Panel
local _, Addon, mortui_settings = ...;

-- Default Settings
mortui_settings = {};
mortui_settings["ShowTracker"] = false;

function MortUISettingsFrame_OnLoad(self)
    local mortUIname = "MortUI"

    local MortUIOptionsPanel = CreateFrame("Frame", O)
    MortUIOptionsPanel.name = mortUIname
    InterfaceOptions_AddCategory(MortUIOptionsPanel)

    local title = MortUIOptionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetText(mortUIname)
    title:SetPoint("TOP")

    showObjectiveTracker = CreateFrame("CheckButton", "showObjectiveTracker_GlobalName", MortUIOptionsPanel, "ChatConfigCheckButtonTemplate");
    showObjectiveTracker:SetPoint("TOPLEFT", 50, -65);
    getglobal(showObjectiveTracker:GetName() .. 'Text'):SetText("Show objective tracker.");
    showObjectiveTracker:SetScript("OnClick", 
        function()
            mortui_settings["ShowTracker"] = showObjectiveTracker_GlobalName:GetChecked();
            message(mortui_settings["ShowTracker"]);
        end);
    MortUIOptionsPanel.RegisterEvent('ADDON_LOADED')
    MortUIOptionsPanel.RegisterEvent('PLAYER_ENTERING_WORLD')
    MortUIOptionsPanel.RegisterEvent('PLAYER_LOGIN')
    MortUIOptionsPanel.RegisterEvent('PLAYER_LOGOUT')
end