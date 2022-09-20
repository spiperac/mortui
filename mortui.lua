local ADDON, Addon = ...

Addon.defaults = {
    loginCount = 0,
    showTracker = true,
}

function Addon:OnLoad()
    -- create and setup options frame and event loader
    local frame = self:CreateHiddenFrame('Frame')

    -- Greet
    message("Welcome to MortUI v1.0.0")

    -- setup an event handler
    frame:SetScript(
        'OnEvent',
        function(_, event, ...)
            local func = self[event]
            if type(func) == 'function' then
                func(self, event, ...)
            end
        end
    )

    frame:RegisterEvent('ADDON_LOADED')
    frame:RegisterEvent('PLAYER_ENTERING_WORLD')
    frame:RegisterEvent('PLAYER_LOGIN')
    frame:RegisterEvent('PLAYER_LOGOUT')
end

function Addon:ADDON_LOADED(event, addonName)
    if ADDON ~= addonName then
        return
    end

    self:InitializeDB();
    self:AddonOptions();
end

function Addon:InitializeDB()
    mortuidb = mortuidb or CopyTable(self.defaults)
    self.db = mortuidb
    mortuidb.loginCount = mortuidb.loginCount + 1;
    Addon.Config = mortuidb
    print(self.db)
end

function Addon:CreateHiddenFrame(...)
    local f = CreateFrame(...)

    f:Hide()

    return f
end

function Addon:AddonOptions()
    local panel = CreateFrame("Frame", O)
    panel.name = "MortUI"

    local objectiveTracker_button = CreateFrame("CheckButton",nil, panel, "InterfaceOptionsCheckButtonTemplate");
    objectiveTracker_button:SetPoint("TOPLEFT", 20, -20);
    objectiveTracker_button:SetText("Display objective tracker.")
    objectiveTracker_button:SetChecked(Addon.Config.showTracker);
    objectiveTracker_button.SetValue = function(_, value)
		self.db.showTracker = (value == "1") -- value can be either "0" or "1"
	end
    objectiveTracker_button:SetChecked(self.db.showTracker);
    objectiveTracker_button:SetScript("OnClick", 
        function()
            mortuidb.showTracker = objectiveTracker_button:GetChecked();
            Addon.Config = mortuidb;
            mortUIShowObjectives();
        end);
    InterfaceOptions_AddCategory(panel);

end

Addon:OnLoad()
-- exports
_G[ADDON] = Addon