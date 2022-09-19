-- myMainBar v2.0 --


--------------------------------------------------------------------------------------------------
-- Localized global variables
--------------------------------------------------------------------------------------------------

MYMAINBAR_HELP = {
	"Usage\n=====\n\nThe action bar is the default one. You can switch between the action bar and the menu bar with the \"Action/Menu Bar\" key binding."
};
BINDING_NAME_MYMAINBAR_TOGGLE = "Action/Menu Bar";

-- Get the client language
local clientLanguage = GetLocale();

-- Check the client language
if (clientLanguage == "frFR") then
	MYMAINBAR_HELP = {
		"Utilisation\n===========\n\nLa barre action est la barre par défaut. Vous pouvez changer entre la barre action et la barre menu avec le raccourci clavier \"Barre Action/Menu\"."
	};
	BINDING_NAME_MYMAINBAR_TOGGLE = "Barre Action/Menu";
end
