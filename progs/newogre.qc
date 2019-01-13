void() ogre_stand1;
void() ogre_walk1;
void() ogre_run1;
void() ogre_melee;
void() ogre_nail1;
void(entity attacker, float damage) ogre_pain;


$cd id1/models/ogre_c
$origin 0 0 24
$base base		
$skin base

$frame	stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7
$frame walk8 walk9 walk10 walk11 walk12 walk13 walk14 walk15 walk16

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame swing1 swing2 swing3 swing4 swing5 swing6 swing7
$frame swing8 swing9 swing10 swing11 swing12 swing13 swing14

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7
$frame smash8 smash9 smash10 smash11 smash12 smash13 smash14

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6

$frame pain1 pain2 pain3 pain4 pain5

$frame painb1 painb2 painb3

$frame painc1 painc2 painc3 painc4 painc5 painc6

$frame paind1 paind2 paind3 paind4 paind5 paind6 paind7 paind8 paind9 paind10
$frame paind11 paind12 paind13 paind14 paind15 paind16

$frame paine1 paine2 paine3 paine4 paine5 paine6 paine7 paine8 paine9 paine10
$frame paine11 paine12 paine13 paine14 paine15

$frame death1 death2 death3 death4 death5 death6
$frame death7 death8 death9 death10 death11 death12
$frame death13 death14

$frame bdeath1 bdeath2 bdeath3 bdeath4 bdeath5 bdeath6
$frame bdeath7 bdeath8 bdeath9 bdeath10

void()	new_ogre_die1	=[	$death1,	new_ogre_die2	] {};
void()	new_ogre_die2	=[	$death2,	new_ogre_die3	] {};
void()	new_ogre_die3	=[	$death3,	new_ogre_die4	]
{self.solid = SOLID_NOT;
self.ammo_rockets = 2;DropBackpack();};
void()	new_ogre_die4	=[	$death4,	new_ogre_die5	] {};
void()	new_ogre_die5	=[	$death5,	new_ogre_die6	] {};
void()	new_ogre_die6	=[	$death6,	new_ogre_die7	] {};
void()	new_ogre_die7	=[	$death7,	new_ogre_die8	] {};
void()	new_ogre_die8	=[	$death8,	new_ogre_die9	] {};
void()	new_ogre_die9	=[	$death9,	new_ogre_die10	] {};
void()	new_ogre_die10	=[	$death10,	new_ogre_die11	] {};
void()	new_ogre_die11	=[	$death11,	new_ogre_die12	] {};
void()	new_ogre_die12	=[	$death12,	new_ogre_die13	] {};
void()	new_ogre_die13	=[	$death13,	new_ogre_die14	] {monster_dead();};
void()	new_ogre_die14	=[	$death14,	new_ogre_die14	] {};

void()	new_ogre_bdie1	=[	$bdeath1,	new_ogre_bdie2	] {};
void()	new_ogre_bdie2	=[	$bdeath2,	new_ogre_bdie3	] {ai_forward(5);};
void()	new_ogre_bdie3	=[	$bdeath3,	new_ogre_bdie4	]
{self.solid = SOLID_NOT;
self.ammo_rockets = 2;DropBackpack();};
void()	new_ogre_bdie4	=[	$bdeath4,	new_ogre_bdie5	] {ai_forward(1);};
void()	new_ogre_bdie5	=[	$bdeath5,	new_ogre_bdie6	] {ai_forward(3);};
void()	new_ogre_bdie6	=[	$bdeath6,	new_ogre_bdie7	] {ai_forward(7);};
void()	new_ogre_bdie7	=[	$bdeath7,	new_ogre_bdie8	] {ai_forward(25);};
void()	new_ogre_bdie8	=[	$bdeath8,	new_ogre_bdie9	] {};
void()	new_ogre_bdie9	=[	$bdeath9,	new_ogre_bdie10	] {monster_dead();};
void()	new_ogre_bdie10	=[	$bdeath10,	new_ogre_bdie10	] {};

void() new_ogre_die =
{
// check for gib
	if (self.health < -80)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_ogre.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		monster_dead();
		return;
	}

	sound (self, CHAN_VOICE, "ogre/ogdth.wav", 1, ATTN_NORM);
	
	if (random() < 0.5)
		new_ogre_die1 ();
	else
		new_ogre_bdie1 ();
};

void() new_monster_ogre =
{



	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/ogre.mdl");

	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 200;
	self.pointvalue = 5;
	
	self.th_stand = ogre_stand1;
	self.th_walk = ogre_walk1;
	self.th_run = ogre_run1;
	self.th_die = new_ogre_die;
	self.th_melee = ogre_melee;
	self.th_missile = ogre_nail1;
	self.th_pain = ogre_pain;
	
	walkmonster_start();
};
