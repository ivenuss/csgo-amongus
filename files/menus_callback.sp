public int ColorMenu_Callback(Menu menu, MenuAction action, int client, int index)
{
	switch (action)
	{
		case MenuAction_Select:
		{
			if (IsValidClient(client))
			{
				char szItem[32];
				menu.GetItem(index, szItem, sizeof(szItem));

				int iColor = StringToInt(szItem);
				//g_iClientColor[client] = iColor;
				
				//SetPlayerColor(client, iColor);
			}
		}
		
		case MenuAction_End:
		{
			delete menu;
		}
	}
}
