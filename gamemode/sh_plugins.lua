GM.Stored = GM.Stored or {};

PLUGIN = {};
hookCache = {};

function GM:LoadPlugins()
  local files, dirs = file.Find("combinecontrol/gamemode/extras/*", "LUA");

  for i, v in ipairs(files) do
    if string.match(v, ".lua") then
      include("combinecontrol/gamemode/extras/" .. v);
      if SERVER then
        AddCSLuaFile("combinecontrol/gamemode/extras/" .. v);
      end
      local oldPLUGIN = PLUGIN;

      self.Stored[oldPLUGIN.Name] = oldPLUGIN;

      PLUGIN = {};
    end
    MsgC(Color(0, 255, 0), "Plugin " .. string.StripExtension(v) .. " has been loaded!\n");
  end

  for i, v in ipairs(dirs) do
    local dirFiles = file.Find("combinecontrol/gamemode/extras/" .. v .. "/*", "LUA");

    if !dirFiles then continue; end

    for i2, v2 in ipairs(dirFiles) do
      if !string.match(v2, ".lua") then continue; end

      if string.match(v2, "sh_") then
        include("combinecontrol/gamemode/extras/" .. v .. "/" .. v2);
        if SERVER then
          AddCSLuaFile("combinecontrol/gamemode/extras/" .. v .. "/" .. v2);
        end
      elseif string.match(v2, "sv_") and SERVER then
        include("combinecontrol/gamemode/extras/" .. v .. "/" .. v2);
      elseif string.match(v2, "cl_") then
        if CLIENT then
          include("combinecontrol/gamemode/extras/" .. v .. "/" .. v2);
        else
          AddCSLuaFile("combinecontrol/gamemode/extras/" .. v .. "/" .. v2);
        end
      end
    end

    local items = file.Find("combinecontrol/gamemode/extras/" .. v .. "/items/*", "LUA");

    if items then
      for i2, v2 in ipairs(items) do
        ITEM = {};
        ITEM.ID = "";
        ITEM.Name = "";
        ITEM.Description = "";
        ITEM.Model = "";
        ITEM.Weight = 1;

        ITEM.ProcessEntity = function() end;
        ITEM.ProcessEntity = function() end;
        ITEM.IconMaterial = nil;
        ITEM.IconColor = nil;

        ITEM.Usable = false;
        ITEM.Droppable = true;
        ITEM.Throwable = true;
        ITEM.UseText = nil;
        ITEM.DeleteOnUse = false;

        ITEM.OnPlayerUse = function() end;
        ITEM.OnPlayerSpawn = function() end;
        ITEM.OnPlayerPickup = function() end;
        ITEM.OnPlayerDeath = function() end;
        ITEM.OnRemoved = function() end;
        ITEM.Think = function() end;

        include("combinecontrol/gamemode/extras/" .. v .. "/items/" .. v2);
        AddCSLuaFile("combinecontrol/gamemode/extras/" .. v .. "/items/" .. v2);

        for i3, v3 in ipairs(self.Items) do
          if v3.ID == ITEM.ID then
            table.remove(self.Items, i3);
          end
        end

        table.insert(self.Items, ITEM);

        if !ITEM.EasterEgg then
          MsgC(Color(255, 100, 0), "Plugin item " .. ITEM.ID .. " has been loaded!\n");
        end
      end

      local ents = file.Find("combinecontrol/gamemode/extras/" .. v .. "/entities/*", "LUA", "nameasc");

      if ents then

        for i2, v2 in ipairs(ents) do
          local prettyName = string.StripExtension(v2);

          _G["ENT"] = {
            Type = "anim",
            Base = "base_gmodentity",
            Spawnable = true
          }

          _G["ENT"].ClassName = prettyName;
          include("combinecontrol/gamemode/extras/" .. v .. "/entities/" .. v2);
          scripted_ents.Register(_G["ENT"], prettyName);

          _G["ENT"] = nil;

          MsgC(Color(0, 255, 255), "Plugin Entity " .. prettyName .. " has been loaded!\n");
        end
      end
    end
    local oldPLUGIN = PLUGIN;

    self.Stored[oldPLUGIN.Name] = oldPLUGIN;

    MsgC(Color(0, 255, 0), "Plugin " .. v .. " has been loaded!\n");

    PLUGIN = {};
  end
  self:CacheHooks();
end

function GM:CacheHooks()
  for i, v in pairs(self.Stored) do

    for i2, v2 in pairs(v) do
      if isfunction(v2) then
        hookCache[i2] = hookCache[i2] or {};
        hookCache[i2][v] = v2;
      end
    end
  end
end
hook.oldCall = hook.oldCall or hook.Call;

function hook.Call(name, gm, ...)
  local cache = hookCache[name];

  if cache then
    for i, v in pairs(cache) do
      local a, b, c, d, e, f = v(i, ...);

      if a != nil then
        return a, b, c, d, e, f;
      end
    end
  end
  return hook.oldCall(name, gm, ...);
end
