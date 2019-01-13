void() demon1_stand1;
void() demon1_walk1;
void() demon1_run1;
void() Demon_MeleeAttack;	
void() demon1_jump1;		
void(entity attacker, float damage)	demon1_pain;

$cd id1/models/demon3
$scale	0.8
$origin 0 0 24
$base base
$skin base

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8

$frame run1 run2 run3 run4 run5 run6

$frame leap1 leap2 leap3 leap4 leap5 leap6 leap7 leap8 leap9 leap10
$frame leap11 leap12

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9

void()	new_demon1_die1		=[	$death1,		new_demon1_die2	] {
sound (self, CHAN_VOICE, "demon/ddeath.wav", 1, ATTN_NORM);};
void()	new_demon1_die2		=[	$death2,		new_demon1_die3	] {};
void()	new_demon1_die3		=[	$death3,		new_demon1_die4	] {};
void()	new_demon1_die4		=[	$death4,		new_demon1_die5	] {};
void()	new_demon1_die5		=[	$death5,		new_demon1_die6	] {};
void()	new_demon1_die6		=[	$death6,		new_demon1_die7	]
{self.solid = SOLID_NOT;};
void()	new_demon1_die7		=[	$death7,		new_demon1_die8	] {};
void()	new_demon1_die8		=[	$death8,		new_demon1_die9	] {monster_dead();};
void()	new_demon1_die9		=[	$death9,		new_demon1_die9 ] {};

void() new_demon_die =
{
// check for gib
	if (self.health < -80)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_demon.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		monster_dead();
		return;
	}

// regular death
	new_demon1_die1 ();
};


void() new_monster_demon1 =
{

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/demon.mdl");

	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 300;
	self.pointvalue = 7;

	self.th_stand = demon1_stand1;
	self.th_walk = demon1_walk1;
	self.th_run = demon1_run1;
	self.th_die = new_demon_die;
	self.th_melee = Demon_MeleeAttack;		// one of two attacks
	self.th_missile = demon1_jump1;			// jump attack
	self.th_pain = demon1_pain;
		
	walkmonster_start();
};


