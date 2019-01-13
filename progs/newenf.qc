void() enf_stand1;
void() enf_walk1;
void() enf_run1;
void(entity attacker, float damage) enf_pain;
void()enf_atk1;




$cd id1/models/enforcer
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame attack1 attack2 attack3 attack4 attack5 attack6
$frame attack7 attack8 attack9 attack10

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10 death11 death12 death13 death14

$frame fdeath1 fdeath2 fdeath3 fdeath4 fdeath5 fdeath6 fdeath7 fdeath8
$frame fdeath9 fdeath10 fdeath11

void()	new_enf_die1	=[	$death1,	new_enf_die2	] {};
void()	new_enf_die2	=[	$death2,	new_enf_die3	] {};
void()	new_enf_die3	=[	$death3,	new_enf_die4	]
{self.solid = SOLID_NOT;self.ammo_cells = 5;DropBackpack();};
void()	new_enf_die4	=[	$death4,	new_enf_die5	] {ai_forward(14);};
void()	new_enf_die5	=[	$death5,	new_enf_die6	] {ai_forward(2);};
void()	new_enf_die6	=[	$death6,	new_enf_die7	] {};
void()	new_enf_die7	=[	$death7,	new_enf_die8	] {};
void()	new_enf_die8	=[	$death8,	new_enf_die9	] {};
void()	new_enf_die9	=[	$death9,	new_enf_die10	] {ai_forward(3);};
void()	new_enf_die10	=[	$death10,	new_enf_die11	] {ai_forward(5);};
void()	new_enf_die11	=[	$death11,	new_enf_die12	] {ai_forward(5);};
void()	new_enf_die12	=[	$death12,	new_enf_die13	] {ai_forward(5);};
void()	new_enf_die13	=[	$death13,	new_enf_die14	] {monster_dead();};
void()	new_enf_die14	=[	$death14,	new_enf_die14	] {};

void()	new_enf_fdie1	=[	$fdeath1,	new_enf_fdie2	] {

};
void()	new_enf_fdie2	=[	$fdeath2,	new_enf_fdie3	] {};
void()	new_enf_fdie3	=[	$fdeath3,	new_enf_fdie4	] 
{self.solid = SOLID_NOT;self.ammo_cells = 5;DropBackpack();};
void()	new_enf_fdie4	=[	$fdeath4,	new_enf_fdie5	] {};
void()	new_enf_fdie5	=[	$fdeath5,	new_enf_fdie6	] {};
void()	new_enf_fdie6	=[	$fdeath6,	new_enf_fdie7	] {};
void()	new_enf_fdie7	=[	$fdeath7,	new_enf_fdie8	] {};
void()	new_enf_fdie8	=[	$fdeath8,	new_enf_fdie9	] {};
void()	new_enf_fdie9	=[	$fdeath9,	new_enf_fdie10	] {};
void()	new_enf_fdie10	=[	$fdeath10,	new_enf_fdie11	] {monster_dead();};
void()	new_enf_fdie11	=[	$fdeath11,	new_enf_fdie11	] {};


void() new_enf_die =
{
// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_mega.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		monster_dead();
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "enforcer/death1.wav", 1, ATTN_NORM);
	if (random() > 0.5)
		new_enf_die1 ();
	else
		new_enf_fdie1 ();
};

void() new_monster_enforcer =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/enforcer.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 80;
	self.pointvalue = 4;

	self.th_stand = enf_stand1;
	self.th_walk = enf_walk1;
	self.th_run = enf_run1;
	self.th_pain = enf_pain;
	self.th_die = new_enf_die;
	self.th_missile = enf_atk1;

	walkmonster_start();
};
