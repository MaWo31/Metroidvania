class_name InputComponent extends Node


var move_dir := 0.0
var jump_pressed := false
var jump_released := false
var dash_pressed := false

func update() -> void:
	move_dir = Input.get_axis("move_left", "move_right")
	jump_pressed = Input.is_action_just_pressed("jump")
	jump_released = Input.is_action_just_released("jump")
	dash_pressed = Input.is_action_just_pressed("dash")
