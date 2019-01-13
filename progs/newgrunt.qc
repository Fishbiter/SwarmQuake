void() army_stand1;
void() army_walk1;
void() army_run1;
void() army_atk1;
void(entity attacker, float damage)	army_pain;
void() DropBackpack;
void() walkmonster_start;
void(string gibname, float dm) ThrowGib;
void(string gibname, float dm) ThrowHead;

$cd id1/models/soldier3
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11

void()	new_army_die1	=[	$death1,	new_army_die2	] {};
void()	new_army_die2	=[	$death2,	new_army_die3	] {};
void()	new_army_die3	=[	$death3,	new_army_die4	]
{self.solid = SOLID_NOT;self.ammo_shells = 5;DropBackpack();};
void()	new_army_die4	=[	$death4,	new_army_die5	] {};
void()	new_army_die5	=[	$death5,	new_army_die6	] {};
void()	new_army_die6	=[	$death6,	new_army_die7	] {};
void()	new_army_die7	=[	$death7,	new_army_die8	] {};
void()	new_army_die8	=[	$death8,	new_army_die9	] {};
void()	new_army_die9	=[	$death9,	new_army_die10	] {monster_dead();};
void()	new_army_die10	=[	$death10,	new_army_die10	] {};

void()	new_army_cdie1	=[	$deathc1,	new_army_cdie2	] {};
void()	new_army_cdie2	=[	$deathc2,	new_army_cdie3	] {ai_back(5);};
void()	new_army_cdie3	=[	$deathc3,	new_army_cdie4	]
{self.solid = SOLID_NOT;self.ammo_shells = 5;DropBackpack();ai_back(4);};
void()	new_army_cdie4	=[	$deathc4,	new_army_cdie5	] {ai_back(13);};
void()	new_army_cdie5	=[	$deathc5,	new_army_cdie6	] {ai_back(3);};
void()	new_army_cdie6	=[	$deathc6,	new_army_cdie7	] {ai_back(4);};
void()	new_army_cdie7	=[	$deathc7,	new_army_cdie8	] {};
void()	new_army_cdie8	=[	$deathc8,	new_army_cdie9	] {};
void()	new_army_cdie9	=[	$deathc9,	new_army_cdie10	] {};
void()	new_army_cdie10	=[	$deathc10,	new_army_cdie11	] {monster_dead();};
void()	new_army_cdie11	=[	$deathc11,	new_army_cdie11	] {};

void() new_army_die =
{
// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_guard.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		monster_dead();
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
//	if (random() < 0.5)
//		new_army_die1 ();
//	else
		new_army_cdie1 ();
};

void() new_monster_army =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/soldier.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 30;
	self.pointvalue = 2;

	self.th_stand = army_stand1;
	self.th_walk = army_walk1;
	self.th_run = army_run1;
	self.th_missile = army_atk1;
	self.th_pain = army_pain;
	self.th_die = new_army_die;

	walkmonster_start ();
};

