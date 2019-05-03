#include <sourcemod>
#include <cstrike>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
    name = "Swap Respawn",
    author = "B3none",
    description = "Respawn a player when they join a team",
    version = "1.0.0",
    url = "https://github.com/b3none"
};

public void OnPluginStart()
{
    HookEvent("player_team", OnJoinTeam);
}

public void OnJoinTeam(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("userid"));
    
    CreateTimer(0.1, RespawnClient, client, TIMER_FLAG_NO_MAPCHANGE);
}

public Action RespawnClient(Handle timer, int client)
{
	int team = GetClientTeam(client);
	
	if (!IsValidClient(client) || IsPlayerAlive(client) || team != CS_TEAM_T || team != CS_TEAM_CT)
    {
        return Plugin_Continue;
    }
    
	CS_RespawnPlayer(client);
	return Plugin_Continue;
}

stock bool IsValidClient(int client)
{
    return client > 0 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client);
}
