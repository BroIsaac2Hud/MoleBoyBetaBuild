/// @description Basic stats and values for the game!

//
// Game By Isaac Sanchez
// Started Summer 2022
//

//
// TODO: Add randomize function when testing random values
//
//randomize();

//
// restart global values (since values may be reassigned after room_restart call,
// but before the end Mole Boy's end step event.
//
func_initialize_globals();

//
// values for changing speed
//
// TODO: Alter when adding more screens/rooms
lay_id = layer_get_id("Background");
boundaryWidth = 16;  // for obj_boundary measure

//
// values for spawning rocks
//
minRockSpawnTime = 20;
maxRockSpawnTime = 40;
rockSpawnTime = irandom_range(minRockSpawnTime, maxRockSpawnTime);
rockWidth = 40;
minRockX = rockWidth;
maxRockX = room_width - rockWidth;
rockX = irandom_range(minRockX, maxRockX);
rockCnt = 0;
rockIncVal = 1 * global.currentExcavationSpeed;  // 1 may be replaced by var that better matches desired spawn rate later in dev

//
// values for spawning rocks
//
minSturdyRockSpawnTime = 100;
maxSturdyRockSpawnTime = 120;
sturdyRockSpawnTime = irandom_range(minSturdyRockSpawnTime, maxSturdyRockSpawnTime);
sturdyRockWidth = 50;  // technically half width
minSturdyRockX = sturdyRockWidth;
maxSturdyRockX = room_width - sturdyRockWidth;
sturdyRockX = irandom_range(minSturdyRockX, maxSturdyRockX);
sturdyRockCnt = 0;
sturdyRockIncVal = 1 * global.currentExcavationSpeed;

//
// values for spawning saws
//
minSawSpawnTime = 80;
maxSawSpawnTime = 100;
sawSpawnTime = irandom_range(minSawSpawnTime, maxSawSpawnTime);
sawWidth = 32;
minSawX = sawWidth;
maxSawX = room_width - sawWidth;
sawX = irandom_range(minSawX, maxSawX);
sawCnt = 0;
sawIncVal = 1 * global.currentExcavationSpeed;

//
// values for spawning worms
//
minWormSpawnTime = 300;
maxWormSpawnTime = 360;
wormSpawnTime = irandom_range(minWormSpawnTime, maxWormSpawnTime);
wormWidth = 64;
minWormX = (room_width / 2) - (wormWidth);
maxWormX = (room_width / 2) + (wormWidth);
wormX = irandom_range(minWormX, maxWormX);
wormCnt = 0;
wormIncVal = 1 * global.currentExcavationSpeed;

//
// values for spawning dug dirt patches
//
maxExclusiveDirtYMultiple = floor(10 / global.currentExcavationSpeed);
currDirtYMultiple = 0;
dirtSpawnDeterminant = 1;  // if global.rockSlowDown is insideRockSpeed, dirt patches will be spawned every other frames because of this var
maxDirtYDiff = floor(96 / global.currentExcavationSpeed)

depth = -1;