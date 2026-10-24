class_name InputComponent extends Node


var move_dir := 0.0
var jump_pressed := false
var jump_released := false
var dash_pressed := false
var attack_pressed := false
var attack_dir := Vector2.ZERO

func update() -> void:
	move_dir = Input.get_axis("move_left", "move_right")
	attack_dir = Input.get_vector("move_left","move_right","look_up","look_down")
	jump_pressed = Input.is_action_just_pressed("jump")
	jump_released = Input.is_action_just_released("jump")
	dash_pressed = Input.is_action_just_pressed("dash")
	attack_pressed = Input.is_action_just_pressed("attack")
