//Loads all sounds
void LoadSounds()
{
	AddFileToDownloadsTable("sound/au/player_join.mp3");
	PrecacheSound("au/player_join.mp3", true);

	AddFileToDownloadsTable("sound/au/player_leave.mp3");
	PrecacheSound("au/player_leave.mp3", true);
}

void LoadIcons()
{
	char szVmtPath[64], szVtfPath[64];

	for (int i = 0; i < MAX_TEAM_COLORS - 1; i++)
	{
		Format(szVmtPath, sizeof(szVmtPath), "materials/au/au_icon%d.vmt", i);
		Format(szVtfPath, sizeof(szVtfPath), "materials/au/au_icon%d.vtf", i);
		
		AddFileToDownloadsTable(szVmtPath);
		PrecacheModel(szVmtPath, true);
		AddFileToDownloadsTable(szVtfPath);
	}
}

void LoadLevels()
{
	char szPath[128];

	for (int i = 0; i < MAX_TEAM_COLORS; i++)
	{
		Format(szPath, sizeof(szPath), "materials/panorama/images/icons/xp/level720%d.png", i);
		AddFileToDownloadsTable(szPath);
	}
}

void PerformColor(int client, int color)
{
	int r, g, b; 
	if (color == 0) { r = 62, g = 68, b = 80; }
	else if (color == 1) { r = 66, g = 247, b = 219; }
	else if (color == 2) { r = 107, g = 71, b = 31; }
	else if (color == 3) { r = 24, g = 45, b = 162; }
	else if (color == 4) { r = 19, g = 108, b = 44; }
	else if (color == 5) { r = 223, g = 119, b = 11; }
	else if (color == 6) { r = 80, g = 236, b = 52; }
	else if (color == 7) { r = 197, g = 72, b = 158; }
	else if (color == 8) { r = 148, g = 16, b = 15; }
	else if (color == 9) { r = 213, g = 220, b = 243; }
	else if (color == 10) { r = 101, g = 52, b = 168; }
	else if (color == 11) { r = 240, g = 244, b = 88; }

	SetEntityRenderMode(client, RENDER_GLOW);
	SetEntityRenderColor(client, r, g, b);

	CreateColorIcon(client);
}

void GetColorString(int color, char[] buffer, int len)
{
	char szBuf[64];
	if (color == 0) szBuf = "Black";
	else if (color == 1) szBuf = "Cyan";
	else if (color == 2) szBuf = "Brown";
	else if (color == 3) szBuf = "Blue";
	else if (color == 4) szBuf = "Green";
	else if (color == 5) szBuf = "Orange";
	else if (color == 6) szBuf = "Lime";
	else if (color == 7) szBuf = "Pink";
	else if (color == 8) szBuf = "Red";
	else if (color == 9) szBuf = "White";
	else if (color == 10) szBuf = "Purple";
	else if (color == 11) szBuf = "Yellow";
	else szBuf = "unknown";

	Format(buffer, len, "%s", szBuf);
}

/* void StartGame()
{
} */

/* void SetPlayerIcon(int client, int color)
{
	return;
} */