public void Hook_OnThinkPost(int iEnt)
{
	int m_iLevelTemp[MAXPLAYERS + 1] = 0;
	GetEntDataArray(iEnt, m_iOffset, m_iLevelTemp, MAXPLAYERS + 1);

	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsValidClient(i))
		{
			if (g_iClientColor[i] != -1)
			{
				char szLevel[64] = "720";
				char szColor[64];
				IntToString(g_iClientColor[i], szColor, sizeof(szColor));
				StrCat(szLevel, sizeof(szLevel), szColor);

				m_iLevel[i] = StringToInt(szLevel);

				if (m_iLevel[i] != -1)
				{
					SetEntData(iEnt, m_iOffset + (i * 4), m_iLevel[i]);
				}
			}
		}
	}
}