void CreateColorIcon(int client)
{
	RemoveIcon(client);

	char iTarget[16];
	Format(iTarget, 16, "client%d", client);
	DispatchKeyValue(client, "targetname", iTarget);
	
	g_iIcon[client] = CreateEntityByName("env_sprite");
	
	if (!g_iIcon[client])
		return;
	
	char iconbuffer[256];
	
	Format(iconbuffer, sizeof(iconbuffer), "materials/au/au_icon%d.vmt", g_iClientColor[client]);

	DispatchKeyValue(g_iIcon[client], "model", iconbuffer);
	DispatchKeyValue(g_iIcon[client], "classname", "env_sprite");
	DispatchKeyValue(g_iIcon[client], "spawnflags", "1");
	DispatchKeyValue(g_iIcon[client], "scale", "0.3");
	DispatchKeyValue(g_iIcon[client], "rendermode", "1");
	DispatchKeyValue(g_iIcon[client], "rendercolor", "255 255 255");
	DispatchSpawn(g_iIcon[client]);
	
	float origin[3];
	GetClientAbsOrigin(client, origin);
	origin[2] = origin[2] + 90.0;
	
	TeleportEntity(g_iIcon[client], origin, NULL_VECTOR, NULL_VECTOR);
	SetVariantString(iTarget);
	AcceptEntityInput(g_iIcon[client], "SetParent", g_iIcon[client], g_iIcon[client], 0);
}

public void RemoveIcon(int client)
{
	if (g_iIcon[client] > 0 && IsValidEdict(g_iIcon[client]))
	{
		AcceptEntityInput(g_iIcon[client], "Kill");
		g_iIcon[client] = -1;
	}
}