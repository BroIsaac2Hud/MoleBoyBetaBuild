if (!global.gamePaused) {
	/// @description Spawn rocks and stuff!
	rockCnt += rockIncVal / global.rockSlowDown;

	// rock will be spawned down now
	if (rockCnt >= rockSpawnTime) {
		instance_create_depth(rockX, room_height + 48, 1, obj_rock_obstacle);
		rockCnt = 0;
		rockSpawnTime = irandom_range(minRockSpawnTime, maxRockSpawnTime);
		// randomize rock timing again
		rockX = irandom_range(minRockX, maxRockX);
		// randomize next rock x-value location again
	}
	
	sturdyRockCnt += sturdyRockIncVal / global.rockSlowDown;

	// sturdy rock will be spawned down now
	if (sturdyRockCnt >= sturdyRockSpawnTime) {
		instance_create_depth(sturdyRockX, room_height + 56, 1, obj_rock_sturdy_obstacle);
		sturdyRockCnt = 0;
		sturdyRockSpawnTime = irandom_range(minSturdyRockSpawnTime, maxSturdyRockSpawnTime);
		// randomize sturdy rock timing again
		sturdyRockX = irandom_range(minSturdyRockX, maxSturdyRockX);
		// randomize next sturdy rock x-value location again
	}
	
	questionRockCnt += questionRockIncVal / global.rockSlowDown;

	// question rock enemy will be spawned down now
	if (questionRockCnt >= questionRockSpawnTime) {
		newQuestionEnemy = instance_create_depth(questionRockX, room_height + 128, 1, obj_question_enemy);
		if (questionRockX < (room_width / 2) ) {
			newQuestionEnemy.currRight = 1;
			newQuestionEnemy.spinEndAngle = newQuestionEnemy.spinStartAngle - newQuestionEnemy.spinEndAngleDiff;
			newQuestionEnemy.spinAngleIncVal *= -1;
			newQuestionEnemy.right = true;
			newQuestionEnemy.mask_index = newQuestionEnemy.rightSprite;
		} else {
			newQuestionEnemy.currRight = -1;
			newQuestionEnemy.spinEndAngle = newQuestionEnemy.spinStartAngle + newQuestionEnemy.spinEndAngleDiff;
			newQuestionEnemy.escapeDistance *= -1;
			newQuestionEnemy.right = false;
			newQuestionEnemy.mask_index = newQuestionEnemy.leftSprite;
		}
		questionRockCnt = 0;
		questionRockSpawnTime = irandom_range(minQuestionRockSpawnTime, maxQuestionRockSpawnTime);
		questionRockX = irandom_range(minQuestionRockX, maxQuestionRockX);
	}

	//
	// spawn saws!
	//
	sawCnt += sawIncVal / global.rockSlowDown;

	// saw will be spawned down now
	if (sawCnt >= sawSpawnTime) {
		instance_create_depth(sawX, room_height + 48, 0, obj_saw_obstacle);
		sawCnt = 0;
		sawSpawnTime = irandom_range(minSawSpawnTime, maxSawSpawnTime);
		// randomize saw timing again
		sawX = irandom_range(minSawX, maxSawX);
		// randomize next saw x-value location again 
	}


	//
	// spawn worms!
	//
	wormCnt += wormIncVal / global.rockSlowDown;

	// worm will be spawned down now
	if (wormCnt >= wormSpawnTime) {
		newWorm = instance_create_depth(wormX, room_height + 48, 0, obj_worm);
		if (wormX >= (room_width / 2) ) {
			newWorm.right = -1;
		} else {
			newWorm.right = 1;
		}
		//
		// Thanks to Gurpreet Singh Matharoo for image-flipping info at 
		// https://gamemakerhow.com/how-to-flip-an-instance-sprite/
		//
		newWorm.image_xscale = -newWorm.right;
		wormCnt = 0;
		wormSpawnTime = irandom_range(minWormSpawnTime, maxWormSpawnTime);
		// randomize worm timing again
		wormX = irandom_range(minWormX, maxWormX);
		// randomize next worm x-value location again 
	}

	if (keyboard_check_pressed(ord("G"))) {
		global.currentExcavationSpeed += 0.5;
		global.layerSpeed = floor(startingLayerSpeed * global.currentExcavationSpeed);
		layer_vspeed(lay_id, -floor(global.layerSpeed / global.rockSlowDown));
		global.speedChange = true;
	}

	if (keyboard_check_pressed(ord("M"))) {
		global.currentMoleBoySpeed += 0.5;
		global.moleBoySpeedChange = true;
	}
	
	if (keyboard_check_pressed(ord("D"))) {
		global.debug = !global.debug;
		if (global.debug) {
			object_set_sprite(obj_rock_obstacle, spr_test_floor);
		}
		else {
			object_set_sprite(obj_rock_obstacle, spr_rock);
		}
		func_save_game();
		func_reset_excavation();
		exit;
	}
}


// Thanks to Shaun Spalding for game pausing explanation from
// "GameMaker Studio 2: Action RPG Tutorial (Part 5: Initialisation/Pausing)"
// Youtube video: https://www.youtube.com/watch?v=JwWuZXyTzN0&t=1s
if (keyboard_check_pressed(vk_escape) && !global.dead) {
	global.gamePaused = !global.gamePaused;
	
	if (global.gamePaused) {
		instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_button_restart);
		func_freeze_screen();
	}
	else {
		with (all) {
			image_speed = gamePausedImageSpeed;
			layer_vspeed(obj_control.lay_id, -floor(global.layerSpeed / global.rockSlowDown));
		}
		instance_destroy(obj_button_restart);
	}
}

if (keyboard_check_pressed(vk_enter) && global.gamePaused && !global.dead) {
	func_reset_excavation();
}

if (keyboard_check_pressed(ord("R"))) {
	func_delete_score();
	func_save_game();
	func_reset_excavation();
	exit;
}