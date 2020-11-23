public Action Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));

	if (IsValidClient(client))
	{
		g_iClientColor[client] = GetRandomColor();
		PerformColor(client, g_iClientColor[client]);

		SetEntityModel(client, "models/player/custom_player/au/spacesuit.mdl");
	}
}