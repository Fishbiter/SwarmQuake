void() func_arena_start = 
{
arenapoints = 30;
};


void() DisappearMonsters = 
{
local entity e;

e = nextent(world);
while (e)
{
if (e.flags & FL_MONSTER)
{
spawn_tfog(e.origin);
remove(e);
}
e = nextent(e);
}
};

void(entity gladiator) startarena = 
{
bprint(gladiator.netname);
bprint(" enters the arena\n");

ZeroScores();
DisappearMonsters();



};

