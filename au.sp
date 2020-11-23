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
#include "files/commands.sp"
#include "addons/icon.sp"
#include "addons/level.sp"

public void OnPluginStart()
{
	RegConsoleCmd("sm_colors", Cmd_Colors);
	RegConsoleCmd("sm_test", Cmd_Test);
	RegConsoleCmd("jointeam", JoinTeam_Callback);

	HookEvent("player_spawn", Event_PlayerSpawn);
	m_iOffset = FindSendPropInfo("CCSPlayerResource", "m_nPersonaDataPublicLevel");
}

public void OnMapStart()
{
	LoadSounds();
	LoadIcons();
	LoadLevels();
	LoadModels();

	LoadMapCvars();

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
