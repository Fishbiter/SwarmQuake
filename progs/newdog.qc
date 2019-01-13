void() dog_stand1;
void() dog_walk1;
void() dog_run1;
void() dog_pain;
void() dog_atta1;
void() dog_leap1;
void() walkmonster_start;
void(string gibname, float dm) ThrowGib;
void(string gibname, float dm) ThrowHead;

$cd id1/models/dog
$origin 0 0 24
$base base
$skin skin

$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

void() new_dog_die1		=[	$death1,	new_dog_die2	] {};
void() new_dog_die2		=[	$death2,	new_dog_die3	] {};
void() new_dog_die3		=[	$death3,	new_dog_die4	] {};
void() new_dog_die4		=[	$death4,	new_dog_die5	] {};
void() new_dog_die5		=[	$death5,	new_dog_die6	] {};
void() new_dog_die6		=[	$death6,	new_dog_die7	] {};
void() new_dog_die7		=[	$death7,	new_dog_die8	] {};
void() new_dog_die8		=[	$death8,	new_dog_die9	] {monster_dead();};
void() new_dog_die9		=[	$death9,	new_dog_die9	] {};

void() new_dog_dieb1		=[	$deathb1,	new_dog_dieb2	] {};
void() new_dog_dieb2		=[	$deathb2,	new_dog_dieb3	] {};
void() new_dog_dieb3		=[	$deathb3,	new_dog_dieb4	] {};
void() new_dog_dieb4		=[	$deathb4,	new_dog_dieb5	] {};
void() new_dog_dieb5		=[	$deathb5,	new_dog_dieb6	] {};
void() new_dog_dieb6		=[	$deathb6,	new_dog_dieb7	] {};
void() new_dog_dieb7		=[	$deathb7,	new_dog_dieb8	] {};
void() new_dog_dieb8		=[	$deathb8,	new_dog_dieb9	] {monster_dead();};
void() new_dog_dieb9		=[	$deathb9,	new_dog_dieb9	] {};

void() new_dog_die =
{
// check for gibs
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowHead ("progs/h_dog.mdl", self.health);
		monster_dead();
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "dog/ddeath.wav", 1, ATTN_NORM);
	self.solid = SOLID_NOT;
	
	if (random() > 0.5)
	 	new_dog_die1 ();
	else
		new_dog_dieb1 ();
};

void() new_monster_dog =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/dog.mdl");

	setsize (self, '-32 -32 -24', '32 32 40');
	self.health = 25;
	self.pointvalue = 1;
	self.th_stand = dog_stand1;
	self.th_walk = dog_walk1;
	self.th_run = dog_run1;
	self.th_pain = dog_pain;
	self.th_die = new_dog_die;
	self.th_melee = dog_atta1;
	self.th_missile = dog_leap1;
	
	walkmonster_start();
};



