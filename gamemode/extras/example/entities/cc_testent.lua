AddCSLuaFile();

--[[
Adding in entities is like normal just make sure they are in the entitites file :)
]]--

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "Test Ent";
ENT.Category = "Combine Control"
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;


if SERVER then
  function ENT:Initialize()
    self:SetModel("models/props_junk/wood_crate001a.mdl");
    self:PhysicsInit(SOLID_VPHYSICS);
  end
else
  function ENT:Draw()
    self:DrawModel();
  end
end
