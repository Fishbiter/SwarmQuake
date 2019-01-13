void() wiz_stand1;
void() wiz_walk1;
void() wiz_run1;
void() Wiz_Missile;
void(entity attacker, float damage) Wiz_Pain;

		
void() flymonster_start;

$cd id1/models/a_wizard
$origin 0 0 24
$base wizbase	
$skin wizbase

$frame hover1 hover2 hover3 hover4 hover5 hover6 hover7 hover8
$frame hover9 hover10 hover11 hover12 hover13 hover14 hover15

$frame fly1 fly2 fly3 fly4 fly5 fly6 fly7 fly8 fly9 fly10
$frame fly11 fly12 fly13 fly14

$frame magatt1 magatt2 magatt3 magatt4 magatt5 magatt6 magatt7
$frame magatt8 magatt9 magatt10 magatt11 magatt12 magatt13

$frame pain1 pain2 pain3 pain4

$frame death1 death2 death3 death4 death5 death6 death7 death8

void()	new_wiz_death1	=[	$death1,		new_wiz_death2	] {

self.velocity_x = -200 + 400*random();
self.velocity_y = -200 + 400*random();
self.velocity_z = 100 + 100*random();
self.flags = self.flags - (self.flags & FL_ONGROUND);
sound (self, CHAN_VOICE, "wizard/wdeath.wav", 1, ATTN_NORM);
};
void()	new_wiz_death2	=[	$death2,		new_wiz_death3	] {};
void()	new_wiz_death3	=[	$death3,		new_wiz_death4	]{self.solid = SOLID_NOT;};
void()	new_wiz_death4	=[	$death4,		new_wiz_death5	] {};
void()	new_wiz_death5	=[	$death5,		new_wiz_death6	] {};
void()	new_wiz_death6	=[	$death6,		new_wiz_death7	] {};
void()	new_wiz_death7	=[	$death7,		new_wiz_death8	] {monster_dead();};
void()	new_wiz_death8	=[	$death8,		new_wiz_death8	] {};

void() new_wiz_die =
{
// check for gib
	if (self.health < -40)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_wizard.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		monster_dead();
		return;
	}

	new_wiz_death1 ();
};

void() new_monster_wizard =
{
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/wizard.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 80;
	self.pointvalue = 4;

	self.th_stand = wiz_stand1;
	self.th_walk = wiz_walk1;
	self.th_run = wiz_run1;
	self.th_missile = Wiz_Missile;
	self.th_pain = Wiz_Pain;
	self.th_die = new_wiz_die;
		
	flymonster_start ();
};
