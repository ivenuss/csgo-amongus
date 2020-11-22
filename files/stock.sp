stock int GetAlivePlayersCount()
{
	int iCountedPlayers = 0;
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsValidClient(i))
		{
			if (GetClientTeam(i) == CS_TEAM_CT && IsPlayerAlive(i))
			{
				iCountedPlayers++;
			}
		}
	}

	return iCountedPlayers;
}

stock int GetRandomColor()
{
	int iExistingColors[MAX_TEAM_COLORS] = -1;
	int iLoadedColors = 0;

	for (int i = 0; i <= MaxClients; i++)
	{
		if (IsValidClient(i) && IsPlayerAlive(i))
		{
			iExistingColors[iLoadedColors] = g_iClientColor[i];
			iLoadedColors++;
		}
	}

	int iColor = -1;
	while (false != true)
	{
		bool breaking;
		iColor = GetRandomInt(0, 11);
		for (int i = 0; i < sizeof(iExistingColors); i++)
		{
			if (iExistingColors[i] == iColor)
			{
				breaking = true;
				break;
			}
		}

		if (breaking) continue;
		break; 
	}

	return iColor;
}

stock bool[] LoadExistingColors()
{
	int iExistingColors[MAX_TEAM_COLORS] = { -1, ... };

	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsValidClient(i) && IsPlayerAlive(i))
		{
			iExistingColors[g_iClientColor[i]] = g_iClientColor[i];
		}
	}

	return iExistingColors;
}

stock bool IsValidClient(int client)
{
	return (0 < client && client <= MaxClients && IsClientInGame(client) && IsFakeClient(client) == false);
}