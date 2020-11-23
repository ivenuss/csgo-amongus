void ColorMenu(int client)
{
	int iExistingColors[MAX_TEAM_COLORS];
	iExistingColors = LoadExistingColors();

	char buffer[128], szColor[64], szTaken[32];

	Menu menu = new Menu(ColorMenu_Callback);
	menu.SetTitle("Choose your color:");
	
	for (int i = 0; i < MAX_TEAM_COLORS; i++)
	{
		char szNum[3];
		IntToString(i, szNum, sizeof(szNum));
		GetColorString(i, szColor, sizeof(szColor));
		
		if (iExistingColors[i] == i && i != g_iClientColor[client]) {
			szTaken = " [TAKEN]";
		} else {
			szTaken = "";
		}

		Format(buffer, sizeof(buffer), "%s%s%s", szColor, (g_iClientColor[client] == i) ? " [YOURS]":"", szTaken);

		menu.AddItem(szNum, buffer, (g_iClientColor[client] == i || strlen(szTaken) > 0) ? ITEMDRAW_DISABLED:ITEMDRAW_DEFAULT );

	}
	
	menu.Display(client, MENU_TIME_FOREVER);
}