void() knight_stand1;
void() knight_walk1;
void() knight_run1;
void() knight_atk1;
void() walkmonster_start;
void(string gibname, float dm) ThrowGib;
void(string gibname, float dm) ThrowHead;
void(entity attacker, float damage) knight_pain;


$cd id1/models/knight
$origin 0 0 24
$base base
$skin badass3

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame runb1 runb2 runb3 runb4 runb5 runb6 runb7 runb8

//frame runc1 runc2 runc3 runc4 runc5 runc6

$frame runattack1 runattack2 runattack3 runattack4 runattack5
$frame runattack6 runattack7 runattack8 runattack9 runattack10
$frame runattack11

$frame pain1 pain2 pain3

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9
$frame painb10 painb11

//frame attack1 attack2 attack3 attack4 attack5 attack6 attack7
//frame attack8 attack9 attack10 attack11

$frame attackb1 attackb1 attackb2 attackb3 attackb4 attackb5
$frame attackb6 attackb7 attackb8 attackb9 attackb10

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9
$frame walk10 walk11 walk12 walk13 walk14

$frame kneel1 kneel2 kneel3 kneel4 kneel5

$frame standing2 standing3 standing4 standing5

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11

void()	new_knight_die1	= [	$death1,	new_knight_die2	] {};
void()	new_knight_die2	=[	$death2,	new_knight_die3	] {};
void()	new_knight_die3	=[	$death3,	new_knight_die4	] 
{self.solid= SOLID_NOT;};
void()	new_knight_die4	=[	$death4,	new_knight_die5	] {};
void()	new_knight_die5	=[	$death5,	new_knight_die6	] {};
void()	new_knight_die6	=[	$death6,	new_knight_die7	] {};
void()	new_knight_die7	=[	$death7,	new_knight_die8	] {};
void()	new_knight_die8	=[	$death8,	new_knight_die9	] {};
void()	new_knight_die9	=[	$death9,	new_knight_die10] {monster_dead();};
void()	new_knight_die10=[	$death10,	new_knight_die10] {};


void()	new_knight_dieb1	=[	$deathb1,	new_knight_dieb2	] {};
void()	new_knight_dieb2	=[	$deathb2,	new_knight_dieb3	] {};
void()	new_knight_dieb3	=[	$deathb3,	new_knight_dieb4	] 	
{self.solid= SOLID_NOT;};
void()	new_knight_dieb4	=[	$deathb4,	new_knight_dieb5	] {};
void()	new_knight_dieb5	=[	$deathb5,	new_knight_dieb6	] {};
void()	new_knight_dieb6	=[	$deathb6,	new_knight_dieb7	] {};
void()	new_knight_dieb7	=[	$deathb7,	new_knight_dieb8	] {};
void()	new_knight_dieb8	=[	$deathb8,	new_knight_dieb9	] {};
void()	new_knight_dieb9	=[	$deathb9,	new_knight_dieb10] {};
void()	new_knight_dieb10 = [	$deathb10,	new_knight_dieb11] {monster_dead();};
void()	new_knight_dieb11 = [	$deathb11,	new_knight_dieb11] {};


void() new_knight_die=
{
// check for gib
	if (self.health < -40)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_knight.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		monster_dead();
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "knight/kdeath.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		new_knight_die1 ();
	else
		new_knight_dieb1 ();
};

void() new_monster_knight=
{
	self.solid= SOLID_SLIDEBOX;
	self.movetype= MOVETYPE_STEP;

	setmodel (self, "progs/knight.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health= 75;
	self.pointvalue= 3;

	self.th_stand= knight_stand1;
	self.th_walk= knight_walk1;
	self.th_run= knight_run1;
	self.th_melee= knight_atk1;
	self.th_pain= knight_pain;
	self.th_die = new_knight_die;
	
	walkmonster_start ();
};
