void(entity gladiator) startarena;

void(entity scorer, float scored) GainPoints = 
{
scorer.pointsgained = scorer.pointsgained + scored;
if (!arenapoints)
	scorer.frags = scorer.pointsgained;
else if (scorer.pointsgained > arenapoints)
	startarena (scorer);
};

