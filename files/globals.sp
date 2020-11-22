#define LOBBY_MIN_PLAYERS 2
#define LOBBY_LOADING_TIME 15
#define MAX_TEAM_COLORS 12

int g_iLobbyCountDown = LOBBY_LOADING_TIME;
int g_iClientColor[MAXPLAYERS + 1] = { -1, ... };
int g_iIcon[MAXPLAYERS + 1] =  { -1, ... };
int m_iOffset = -1;
int m_iLevel[MAXPLAYERS + 1] = -1;
bool g_bIsLobby = true;

Handle g_hLobbyTimer; 
