#include a_samp
#include zcmd
#include sscanf2

#define GREEN	"{00FF00}"
#define GRAY 	"{8F8F8F}"
#define RED 	"{FF0000}"
#define WHITE 	"{FFFFFF}"

#define MAX_PLAYER_CASAS 10 //MAXIMO DE CASAS POR JOGADOR.
#define MAX_CASA_MADEIRA 45 //MAXIMO DE OBJETOS DA CASA DE MADEIRA.

enum enum_casa {
	objeto_modelo,
	Float:objeto_x,
	Float:objeto_y,
	Float:objeto_z,
	
	Float:objeto_rx,
	Float:objeto_ry,
	Float:objeto_rz,
}

enum enum_player_casas {
	bool:casa_atividade,
	casa_objeto[MAX_CASA_MADEIRA],
	Text3D:casa_label[MAX_CASA_MADEIRA],

	
	Float:porta_x,
	Float:porta_y,
	Float:porta_z,
	bool:porta_estado,
	bool:janelas_estado
}

new casa_madeira[MAX_CASA_MADEIRA][enum_casa] = {
	{3798, 43.61880, 1761.33789, 16.61903,   0.00000, 0.00000, 0.00000},
	{3798, 43.61810, 1761.33789, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1759.33728, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1759.33728, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1763.34033, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1763.34033, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1765.32996, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1765.32996, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1767.31372, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1767.31372, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1769.24915, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 43.61880, 1769.24915, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 45.62350, 1759.33728, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 45.62350, 1759.33728, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 47.60400, 1759.33728, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 47.60400, 1759.33728, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 49.60110, 1759.33728, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 49.60110, 1759.33728, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 51.58880, 1759.33728, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 51.58880, 1759.33728, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1759.33728, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1759.33728, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1761.31921, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1763.30481, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1765.28687, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1767.26855, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1769.24915, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 51.57380, 1769.24915, 15.33280,   0.00000, 0.00000, 0.00000},
	{3798, 49.58140, 1769.24915, 15.33280,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1761.31921, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1763.30481, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1765.28687, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1767.26855, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 53.56760, 1769.24915, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 51.57380, 1769.24915, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 49.58140, 1769.24915, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 47.60040, 1769.24915, 18.61000,   0.00000, 0.00000, 0.00000},
	{3798, 45.59880, 1769.24915, 18.61000,   0.00000, 0.00000, 0.00000},
	{19377, 48.60540, 1764.23022, 20.51650,   0.00000, 90.00000, 0.00000},
	{3798, 47.57810, 1769.24915, 16.61900,   0.00000, 0.00000, 0.00000},
	{3798, 49.58140, 1769.24915, 20.61762,   180.00000, 0.00000, 0.00000},
	{3798, 51.57380, 1769.24915, 20.61760,   180.00000, 0.00000, 0.00000},
	{19325, 50.61561, 1769.70996, 17.22270,   0.00000, 0.00000, 90.00000},
	{19303, 44.28300, 1769.79675, 17.76070,   0.00000, 0.00000, 0.00000},
	{1497, 45.09679, 1769.72375, 16.50139,   0.00000, 0.00000, 0.00000} //porta fechada
};
new jogador_casa[MAX_PLAYERS][MAX_PLAYER_CASAS][enum_player_casas];

command(casa, playerid, params []) {
	new comando[32], index;
	if(sscanf(params, "s[32]I(-1)", comando, index)) {
		SendClientMessage(playerid, -1, GREEN"Comandos disponiveis: "WHITE"maximo de casas por jogador "RED"10");
		SendClientMessage(playerid, -1, "    criar, porta, janela");
		SendClientMessage(playerid, -1, "Exemplo de uso "GRAY"/casa criar");
		return true;
	}
	if(!strcmp(comando, "criar", true)) {
		if(index != -1) return SendClientMessage(playerid, -1, RED"inválido: "WHITE"use /casa "RED"criar");
		CreateHouse(playerid);
		return true;
	}
	if(!strcmp(comando, "porta", true)) {
		if(index == -1) return SendClientMessage(playerid, -1, RED"inválido: "WHITE"use /casa porta "RED"[casaid]");
		if(jogador_casa[playerid][index][casa_atividade] == false) return SendClientMessage(playerid, -1, RED"invalido: "WHITE"esta casa nao existe ou você não é o dono.");
		if(jogador_casa[playerid][index][porta_estado] == true) {
			jogador_casa[playerid][index][porta_estado] = false;
			SetObjectRot(jogador_casa[playerid][index][casa_objeto][44], 0.00000, 0.00000, -100.00000);
			GameTextForPlayer(playerid, "~r~Aberta", 4000, 1);
		}
		else {
			jogador_casa[playerid][index][porta_estado] = true;
			SetObjectRot(jogador_casa[playerid][index][casa_objeto][44], 0.00000, 0.00000, 0.00000);
			GameTextForPlayer(playerid, "~g~Fechada", 4000, 1);	
		}
		return true;
	}
	if(!strcmp(comando, "janela", true)) {
		if(index == -1) return SendClientMessage(playerid, -1, RED"inválido: "WHITE"use /casa janela "RED"[casaid]");
		SendClientMessage(playerid, -1, "terminar comando.. objetos 26 e 27.. mover para cima e tals..");
		return true;
	}
	return true;
}

command(ircasa, playerid, params []) {
	new id;
	if(sscanf(params, "i", id)) return true;
	new Float:ppos[3];
	GetObjectPos(jogador_casa[playerid][id][casa_objeto][38], ppos[0], ppos[1], ppos[2]);
	SetPlayerPos(playerid, ppos[0], ppos[1], ppos[2] - 3);
	return true;
}

stock CreateHouse(playerid) {
	new string[10];
	new Float:x, Float:y, Float:z, Float:casa_z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid, x + 3, y, z);
	new index = ObterIndexValido(playerid);
	if(index == MAX_PLAYER_CASAS+1) return SendClientMessage(playerid, -1, RED"Maximo de casas por jogador atingido");
	for(new i = 0; i < MAX_CASA_MADEIRA; i++) {
		if(i > 0) GetObjectPos(jogador_casa[playerid][index][casa_objeto][0], x, y, z);
		if(i == 0) {
			jogador_casa[playerid][index][casa_atividade] = true;
			jogador_casa[playerid][index][porta_estado] = true;
			jogador_casa[playerid][index][casa_objeto][i] = CreateObject(casa_madeira[i][objeto_modelo], x,  y, z, casa_madeira[i][objeto_rx], casa_madeira[i][objeto_ry], casa_madeira[i][objeto_rz]);
		}
		format(string, sizeof string, "index %d", i);
		jogador_casa[playerid][index][casa_objeto][i] = CreateObject(casa_madeira[i][objeto_modelo], floatsub(casa_madeira[i][objeto_x], x), floatsub(casa_madeira[i][objeto_y], y), z - casa_madeira[i][objeto_z], casa_madeira[i][objeto_rx], casa_madeira[i][objeto_ry], casa_madeira[i][objeto_rz]);
		jogador_casa[playerid][index][casa_label][i] = Create3DTextLabel(string, -1, floatsub(casa_madeira[i][objeto_x], x), floatsub(casa_madeira[i][objeto_y], y), z - casa_madeira[i][objeto_z] + z, 3.0, 0); 
	}
	return true;
}

stock ObterIndexValido(playerid) {
	for(new i = 0; i < MAX_PLAYER_CASAS; i++) {
		if(jogador_casa[playerid][i][casa_atividade] == true) continue;
		if(i == MAX_PLAYER_CASAS-1) return MAX_PLAYER_CASAS+1;
		return i;
	}
	return false;
}

stock TesteMat() {
	new Float:x, Float:y, Float:z;
	x = 10.0;
	y = 10.0;
	z = 10.0;
	for(new i = 0; i < 10; i++) {
	for(new i = 0; i < MAX_CASA_MADEIRA; i++) {
		if(i > 0) GetObjectPos(jogador_casa[0][index][casa_objeto][0], x, y, z);
		if(i == 0) {
			x = 10.0;
			y = 10.0;
			z = 10.0;
		}
		x = (10.0 - 5);
		y = (10.0 - 5);
		if(i = 5 || i = 6 || i = 7) {
			z = (10.0 - random(2));
		}
		
	}
}




