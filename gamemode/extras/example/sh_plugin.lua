local PLUGIN = PLUGIN;

-- These fields are required for your plugin to show up in the help menu!
PLUGIN.Name = "Name!";
PLUGIN.Author = "Your name";
PLUGIN.Description = "Showing how to add stuff";

--[[
Adding stuff is very simple, files prefixed with sh, cl and sv are automatically included in the correct realms


for example adding a think hook would look like this

function PLUGIN:Think()
  self.nextThink = self.nextThink or CurTime();

  if self.nextThink < CurTime() then
    print("We are thinking with plugins!");
    self.nextThink = CurTime() + 5;
  end
end
]]--
