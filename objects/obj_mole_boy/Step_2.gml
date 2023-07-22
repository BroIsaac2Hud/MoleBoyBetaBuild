/// @description Enemy/obstacle collision, worm meter depletion
if (global.gamePaused) {
	exit;
}

//
// worm collision
//
if (place_meeting(x, y, obj_worm)) {
	right = instance_nearest(x, y, obj_worm).right;
	instance_destroy(instance_nearest(x, y, obj_worm));
	eatenWorm = instance_create_depth(x, y + 32, -6, obj_worm_eaten);
	eatenWorm.image_xscale = -right;
	// min function keeps bar from overflowing
	wormMeterVal = min(wormMeterMax, wormMeterVal + wormBoost);  // Delicious worm!
}

//
// saw collision
//
if (place_meeting(x, y, obj_saw_obstacle) && !global.debug) {
	func_initialize_death_screen();
	exit;
}

currStep = endStepVal;
state(currStep);

//
// sturdy rock collision
//
if (place_meeting(x, y, obj_rock_sturdy_obstacle) && !global.debug) {
	func_initialize_death_screen();
	exit;
}

//
// question rock collision
//
if (place_meeting(x, y, obj_rock_question)) {
	instance_destroy(instance_nearest(x, y, obj_rock_question));
}

//
// rock collision
//
if ( (global.rockSlowDown & outsideRockSpeed) && 
	(place_meeting(x, y, obj_rock_obstacle) || place_meeting(x, y, obj_big_rock_obstacle)) ) {
	func_switchTo_inRock();
} 
//
// Now must check if mole is out of rock to revert speed to normal.
//
else if ( (global.rockSlowDown & insideRockSpeed) && !place_meeting(x, y, obj_rock_obstacle) 
	&& !place_meeting(x, y, obj_big_rock_obstacle) ) {
	func_switchFrom_inRock();
}


//
// enemy collision
//
if (place_meeting(x, y, obj_question_enemy)) {
	var questionEnemy = instance_nearest(x, y, obj_question_enemy);
	if (!questionEnemy.escaping) {
		questionEnemy.func_reset_spin();
		questionEnemy.escaping = true;
		questionEnemy.currentSprite = questionEnemy.escapingSprite;
	}
}

//
// Time to add to depth
//
global.currentDepth += (global.scoreIncrementVal / global.rockSlowDown);

//
// Time to calculate worm count
//
wormDecreaseCnt += global.rockSlowDown;  // for rock collision worm meter penalty
// removing from worm meter
if (wormDecreaseCnt >= wormDecrementTime) {
	wormDecreaseCnt = 0;
	wormMeterVal -= wormDecrementVal;
	if (wormMeterVal <= 0 && !global.debug) {
		func_initialize_death_screen();
		exit;
	} 
	else if (global.debug) {
		wormMeterVal = wormMeterMax;
	}
}