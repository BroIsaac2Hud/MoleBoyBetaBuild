/// @description Enemy/obstacle collision, worm meter depletion


//
// worm collision
//
if (place_meeting(x, y, obj_worm)) {
	right = instance_nearest(x, y, obj_worm).right;
	instance_destroy(instance_nearest(x, y, obj_worm));
	eatenWorm = instance_create_depth(x, y + 32, -6, obj_worm_eaten);
	eatenWorm.image_xscale = -right;
	// min function keeps bar from overflowing
	wormMeterVal = min(wormMeterMax, wormMeterVal + wormEatenBoost);  // Delicious worm!
}

//
// saw collision
//
if (place_meeting(x, y, obj_saw_obstacle)) {
	func_reset_excavation();
}

//
// currStep = endStepVal;
//
// state(currStep);
//

//
// rock collision
//
// The status "destroyed" for regular rocks is checked to set destroyed
// status to "true" so that rocks can play a shattering animation before
// being destroyed.
//
// NOTE: outer if-statement could be added to !inRock else-if-statement for possibly better performance
//
if ( place_meeting(x, y, obj_rock_obstacle) || place_meeting(x, y, obj_big_rock_obstacle) ) {
	if (drilling) {  // "destroy" rock
		func_destroy_rocks();
		if (place_meeting(x, y, obj_big_rock_obstacle)) {
			instance_destroy(instance_nearest(x, y, obj_big_rock_obstacle));
		}
	} else if (!inRock) {  // digging through rock slowly
		func_switchTo_inRock();
	}
} 
//
// Now must check if mole is out of rock to revert speed to normal.
//
if (inRock && !place_meeting(x, y, obj_rock_obstacle) 
	&& !place_meeting(x, y, obj_big_rock_obstacle) ) {
	func_switchFrom_inRock();
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
if (wormDecreaseCnt >= wormDecreaseTime) {
	wormDecreaseCnt = 0;
	wormMeterVal -= wormDepletion;
	if (wormMeterVal <= 0) {
		func_reset_excavation();  // DEATH
	}
}
