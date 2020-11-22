#include <sourcemod>
#include <cstrike>
#include <sdktools>
#include <sdkhooks>
#include <colors_csgo>

#pragma semicolon 1
#pragma newdecls required

#include "files/globals.sp"
#include "files/events.sp"
#include "files/menus.sp"
#include "files/func.sp"
#include "files/stock.sp"
#include "files/menus_callback.sp"
#include "files/timers.sp"
//#include "files/commands.sp"
#include "addons/icon.sp"
#include "addons/level.sp"

public void OnPluginStart()
{
	RegConsoleCmd("sm_colors", Cmd_Colors);
	RegConsoleCmd("jointeam", JoinTeam_Callback);

	HookEvent("player_spawn", Event_PlayerSpawn);
	m_iOffset = FindSendPropInfo("CCSPlayerResource", "m_nPersonaDataPublicLevel");
}

public void OnMapStart()
{
	LoadSounds();
	LoadIcons();
	LoadLevels();

	delete g_hLobbyTimer;
	g_hLobbyTimer = CreateTimer(1.0, Timer_LobbyCount, _, TIMER_REPEAT);

	/* LEVEL ICONS */
	int iIndex = FindEntityByClassname(MaxClients+1, "cs_player_manager");

	if (iIndex == -1)
	{
		SetFailState("Unable to find cs_player_manager entity");
	}
	SDKHook(iIndex, SDKHook_ThinkPost, Hook_OnThinkPost);
}

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

public void OnClientPutInServer(int client)
{
	if (IsValidClient(client))
	{
		if (g_bIsLobby)
		{
			EmitSoundToAll("au/player_join.mp3");
			CPrintToChatAll("%N joined", client);
		}
	}
}

public void OnClientDisconnect(int client)
{
	if (IsValidClient(client))
	{
		g_iClientColor[client] = -1;

		if (GetClientTeam(client) != CS_TEAM_SPECTATOR)
		{
			EmitSoundToAll("au/player_leave.mp3");
			CPrintToChatAll("%N left", client);
		}
	}
}
