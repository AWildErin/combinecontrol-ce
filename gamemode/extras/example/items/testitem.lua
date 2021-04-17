ITEM.ID				= "testitem";
ITEM.Name			= "Plugin Item";
ITEM.Description	= "Damn I have been created by a plugin.";
ITEM.Model			= "models/props_junk/garbage_plasticbottle002a.mdl";
ITEM.Weight 		= 2;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )

	if( CLIENT ) then

		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the mysterious liquid. Great idea!", { CB_ALL, CB_IC } );

	else

		ply:Kill();

	end

end
