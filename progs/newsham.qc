void() sham_stand1;
void() sham_walk1;
void() sham_run1;
void() sham_melee;
void() sham_magic1;
void(entity attacker, float damage) sham_pain;

$cd id1/models/shams
$origin 0 0 24
$base base		
$skin base

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 
$frame walk8 walk9 walk10 walk11 walk12

$frame	run1 run2 run3 run4 run5 run6

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7 
$frame smash8 smash9 smash10 smash11 smash12

$frame swingr1 swingr2 swingr3 swingr4 swingr5 
$frame swingr6 swingr7 swingr8 swingr9

$frame swingl1 swingl2 swingl3 swingl4 swingl5 
$frame swingl6 swingl7 swingl8 swingl9

$frame magic1 magic2 magic3 magic4 magic5 
$frame magic6 magic7 magic8 magic9 magic10 magic11 magic12

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame death1 death2 death3 death4 death5 death6 
$frame death7 death8 death9 death10 death11

void() new_sham_death1      =[      $death1,       new_sham_death2     ] {};
void() new_sham_death2      =[      $death2,       new_sham_death3     ] {};
void() new_sham_death3      =[      $death3,       new_sham_death4     ] {self.solid = SOLID_NOT;};
void() new_sham_death4      =[      $death4,       new_sham_death5     ] {};
void() new_sham_death5      =[      $death5,       new_sham_death6     ] {};
void() new_sham_death6      =[      $death6,       new_sham_death7     ] {};
void() new_sham_death7      =[      $death7,       new_sham_death8     ] {};
void() new_sham_death8      =[      $death8,       new_sham_death9     ] {};
void() new_sham_death9      =[      $death9,       new_sham_death10    ] {};
void() new_sham_death10     =[      $death10,      new_sham_death11    ] {monster_dead();};
void() new_sham_death11     =[      $death11,      new_sham_death11    ] {};

void() new_sham_die =
{
// check for gib
	if (self.health < -60)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_shams.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		monster_dead();
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "shambler/sdeath.wav", 1, ATTN_NORM);
	new_sham_death1 ();
};

void() new_monster_shambler =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, "progs/shambler.mdl");

	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 600;
	self.pointvalue = 12;

	self.th_stand = sham_stand1;
	self.th_walk = sham_walk1;
	self.th_run = sham_run1;
	self.th_die = new_sham_die;
	self.th_melee = sham_melee;
	self.th_missile = sham_magic1;
	self.th_pain = sham_pain;
	
	walkmonster_start();
};
