/// @description Draw Mole Boy and drill residue!
function func_mole_boy_sprite() {
	if (currentSprite == normalSprite) {
		draw_sprite_ext(bottomDrillSprite, -1, x, y, 1, 1, image_angle, c_white, 1);
	}
	draw_sprite_ext(currentSprite, -1, x, y, 1, 1, image_angle, c_white, 1);
	if (currentSprite == normalSprite) {
		draw_sprite_ext(topDrillSprite, -1, x, y, 1, 1, image_angle, c_white, 1);
	}
}

function func_question_enemy_sprite() {
	draw_sprite_ext(currentSprite, -1, x, y, currRight, 1, spinAngle - spinStartAngle, c_white, escapeAlpha);
	//draw_sprite_ext(earSprite, -1, x, y, currRight, 1, 0, c_white, escapeAlpha);
	//draw_sprite_ext(armSprite, -1, x, y, currRight, 1, 0, c_white, escapeAlpha);
	//draw_sprite_ext(legSprite, -1, x, y, currRight, 1, 0, c_white, escapeAlpha);
}