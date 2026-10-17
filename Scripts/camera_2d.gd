extends Camera2D


var look_ahead_x = 150.0
var look_ahead_y = -100.0

var camera_offset_y := -100.0
@export var player: Player

var smooth_speed_x := 3.0
var smooth_speed_y := 3.0

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	smooth_speed_y = 3.0
	var target_offset = Vector2.ZERO
	
	target_offset.x = player.player_movement.facing_dir * look_ahead_x
	if player.player_states.current_state != player.player_states.State.FALL:
		target_offset.y = camera_offset_y
	else: 
		target_offset.y = camera_offset_y + abs(player.velocity.y) / 5
		smooth_speed_y = 1.0
	offset.x = lerp(offset.x, target_offset.x, delta * smooth_speed_x)
	offset.y = lerp(offset.y, target_offset.y, delta * smooth_speed_y)
