public Action Cmd_Colors(int client, int args)
{
	if (IsValidClient(client))
	{
		ColorMenu(client);
	}

	return Plugin_Handled;
}

public Action JoinTeam_Callback(int client, int args)
{
	if (IsValidClient(client))
	{
		char szTeam[3];
		GetCmdArg(1, szTeam, sizeof(szTeam));
		
		int iNewTeam = StringToInt(szTeam);

		if (iNewTeam == CS_TEAM_SPECTATOR)
		{
			RemoveIcon(client);
			g_iClientColor[client] = -1;
			m_iLevel[client] = -1;
		}
	}
}

public Action Cmd_Test(int client, int args)
{
	if (IsValidClient(client))
	{
		int test = GetClientMenu(client);
		PrintToChat(client, "Test: %d", test);
	}
	return Plugin_Handled;
}