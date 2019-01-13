/*
various essential monster modifications
new monster types required to avoid precache disasters
*/
void() new_monster_dog;
void() new_monster_army;
void() new_monster_knight;
void() new_monster_ogre;
void() new_monster_enforcer;
void() new_monster_demon1;
void() new_monster_wizard;
void() new_monster_shambler;
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;

void() removecorpse = 
{
spawn_tfog(self.origin);
remove(self);
total_monsters = total_monsters - 1;
};

void() monster_dead = 
{
self.think = removecorpse;
self.nextthink = time + (spawntime * 5);
};

// end of monster alterations

vector() randomvector =
{
local float rvx;
local float rvy;
local float rvz;
local vector retvec;

rvx=(random() * 2000) - 1000;
rvy=(random() * 2000) - 1000;
rvz=(random() * 2000) - 1000;

retvec_x = rvx;
retvec_y = rvy;
retvec_z = rvz;

return retvec;
}; 

void(entity asker) ShowSwarmScores =
{
local entity e;
local string s;

e = find(world, classname, "player");
while (e)
{
sprint(asker, e.netname);
sprint(asker, " has scored ");
s = ftos(e.frags);
sprint(asker, s);
sprint(asker, " ");
e = find(e, classname, "player");
}

sprint(asker, "\n");
};


void() ZeroScores =
{
local entity e;

e = find(world, classname, "player");
while (e)
{
e.pointsgained = 0;
if (!arenapoints)
	e.frags = 0;
e = find(e, classname, "player");
}

bprint(self.netname);
bprint(" zeroed scores\n");

};

void() CheckForZero =
{
local entity e;
local float pcount;

e = find(world, classname, "player");
pcount = 0;

while (e)
{
pcount = pcount + 1;
e = find(e, classname, "player");
}

if (pcount == 1)
	ZeroScores();
};

entity (entity start) freespot =
{
local entity firstspot;
local entity e;
local float truefalse;
local float foundobject;
if (start.classname != "info_player_deathmatch")
	start = find(world, classname, "info_player_deathmatch");
if (start == world)
	return world;

firstspot = start;

while (truefalse == FALSE)
{
start = find(start, classname, "info_player_deathmatch");
foundobject = FALSE;
e = findradius(start.origin, 64);
while (e)
{
if (e.takedamage == DAMAGE_AIM)
	foundobject = TRUE;
e = e.chain;
}
if (!foundobject)
	return start;
if (start == firstspot)
	return world;
}
return world;
}; 

void() spawnmebaby = 
{
local float restspot;
local float restcount;
local vector spotpos;
local entity spot;
local entity thistarget;

if (total_monsters > maxmonsters)
{
	self.nextthink = time + (spawntime * 3);
	return;
}

spot = world;
restspot = random() * 32;

while (restcount < restspot)
{
	spot = freespot(spot);
	if (spot == world)
	{
		self.nextthink = time + 0.1;
		return;
	}
	restcount = restcount + 1;
}

spotpos = spot.origin;
thistarget = find(world, targetname, "swarmcreated");
setorigin(thistarget, randomvector());

spot = spawn();
setorigin(spot, spotpos);
restspot = random(); //reuse variable
restspot = (restspot * (1 / (skill + 1))) + (1 - (1 / (skill + 1)));  
if (restspot < 0.25)
	spot.think = new_monster_dog;
else if (restspot < 0.5)
	spot.think = new_monster_army;
else if (restspot < 0.6)
	spot.think = new_monster_knight;
else if (restspot < 0.7)
	spot.think = new_monster_wizard;
else if (restspot < 0.8)
	spot.think = new_monster_enforcer;
else if (restspot < 0.9) 
	spot.think = new_monster_ogre;
else if (restspot < 0.98)
	spot.think = new_monster_demon1;
else
	spot.think = new_monster_shambler;

spot.nextthink = time + 0.1;
spot.target = thistarget.targetname;

spawn_tfog(spot.origin + v_forward*20);
spawn_tdeath(spot.origin, spot);

self.nextthink = time + spawntime;
};
	
void() startswarm =
{
swarmstarted = TRUE; 
if (skill == 0)
{
	maxmonsters = 10;
	spawntime = 1;
}
else if (skill == 1)
{
	maxmonsters = 20;
	spawntime = 0.5;
}
else if (skill == 2)
{
	maxmonsters = 30;
	spawntime = 0.25;
}
else
{
	maxmonsters = 40;
	spawntime = 0.1;
}

local entity spawner;
spawner = spawn();
spawner.think = spawnmebaby;
spawner.nextthink = time + 1;

spawner = spawn();
spawner.targetname = "swarmcreated";
spawner.classname = "path_corner";

};

void() swarmprecache =
{
	precache_model ("progs/h_dog.mdl");
	precache_model ("progs/dog.mdl");

	precache_sound ("dog/dattack1.wav");
	precache_sound ("dog/ddeath.wav");
	precache_sound ("dog/dpain1.wav");
	precache_sound ("dog/dsight.wav");
	precache_sound ("dog/idle.wav");

	precache_model ("progs/soldier.mdl");
	precache_model ("progs/h_guard.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_sound ("soldier/death1.wav");
	precache_sound ("soldier/idle.wav");
	precache_sound ("soldier/pain1.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");

	precache_sound ("player/udeath.wav");

	precache_model ("progs/knight.mdl");
	precache_model ("progs/h_knight.mdl");

	precache_sound ("knight/kdeath.wav");
	precache_sound ("knight/khurt.wav");
	precache_sound ("knight/ksight.wav");
	precache_sound ("knight/sword1.wav");
	precache_sound ("knight/sword2.wav");
	precache_sound ("knight/idle.wav");

	precache_model ("progs/ogre.mdl");
	precache_model ("progs/h_ogre.mdl");
	precache_model ("progs/grenade.mdl");

	precache_sound ("ogre/ogdrag.wav");
	precache_sound ("ogre/ogdth.wav");
	precache_sound ("ogre/ogidle.wav");
	precache_sound ("ogre/ogidle2.wav");
	precache_sound ("ogre/ogpain1.wav");
	precache_sound ("ogre/ogsawatk.wav");
	precache_sound ("ogre/ogwake.wav");

	precache_model2 ("progs/enforcer.mdl");
	precache_model2 ("progs/h_mega.mdl");
	precache_model2 ("progs/laser.mdl");

	precache_sound2 ("enforcer/death1.wav");
	precache_sound2 ("enforcer/enfire.wav");
	precache_sound2 ("enforcer/enfstop.wav");
	precache_sound2 ("enforcer/idle1.wav");
	precache_sound2 ("enforcer/pain1.wav");
	precache_sound2 ("enforcer/pain2.wav");
	precache_sound2 ("enforcer/sight1.wav");
	precache_sound2 ("enforcer/sight2.wav");
	precache_sound2 ("enforcer/sight3.wav");
	precache_sound2 ("enforcer/sight4.wav");

	precache_model ("progs/demon.mdl");
	precache_model ("progs/h_demon.mdl");

	precache_sound ("demon/ddeath.wav");
	precache_sound ("demon/dhit2.wav");
	precache_sound ("demon/djump.wav");
	precache_sound ("demon/dpain1.wav");
	precache_sound ("demon/idle1.wav");
	precache_sound ("demon/sight2.wav");

	precache_model ("progs/wizard.mdl");
	precache_model ("progs/h_wizard.mdl");
	precache_model ("progs/w_spike.mdl");

	precache_sound ("wizard/hit.wav");		// used by c code
	precache_sound ("wizard/wattack.wav");
	precache_sound ("wizard/wdeath.wav");
	precache_sound ("wizard/widle1.wav");
	precache_sound ("wizard/widle2.wav");
	precache_sound ("wizard/wpain.wav");
	precache_sound ("wizard/wsight.wav");	

	precache_model ("progs/shambler.mdl");
	precache_model ("progs/s_light.mdl");
	precache_model ("progs/h_shams.mdl");
	precache_model ("progs/bolt.mdl");
	
	precache_sound ("shambler/sattck1.wav");
	precache_sound ("shambler/sboom.wav");
	precache_sound ("shambler/sdeath.wav");
	precache_sound ("shambler/shurt2.wav");
	precache_sound ("shambler/sidle.wav");
	precache_sound ("shambler/ssight.wav");
	precache_sound ("shambler/melee1.wav");
	precache_sound ("shambler/melee2.wav");
	precache_sound ("shambler/smack.wav");

};

