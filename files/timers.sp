public Action Timer_LobbyCount(Handle timer)
{
	int iAlivePlayers = GetAlivePlayersCount();
	if (iAlivePlayers < LOBBY_MIN_PLAYERS)
	{
		g_iLobbyCountDown = LOBBY_LOADING_TIME;

		for (int i = 1; i <= MaxClients; i++)
		{
			if (IsValidClient(i))
			{
				SetHudTextParams(0.02, 0.700, 1.0, 0, 255, 0, 255, 0, 0.00, 0.3, 0.4);
				ShowHudText(i, 1, "Waiting for players - %i/%d", iAlivePlayers, LOBBY_MIN_PLAYERS);
			}
		}
	}
	
	else
	{
		if (g_iLobbyCountDown > 0)
		{
			for (int i = 1; i <= MaxClients; i++)
			{
				if (IsValidClient(i))
				{
					SetHudTextParams(0.02, 0.700, 1.2, 0, 255, 0, 255, 0, 0.00, 0.3, 0.4);
					ShowHudText(i, 1, "Game will start in %d second%s", g_iLobbyCountDown, (g_iLobbyCountDown == 1) ? "":"s");
				}
			}

			g_iLobbyCountDown--;
		}

		else
		{
			KillTimer(g_hLobbyTimer);
		}
	}
}
