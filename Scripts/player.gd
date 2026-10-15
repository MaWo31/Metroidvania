class_name Player extends CharacterBody2D

@onready var player_movement: PlayerMovement = %PlayerMovement
@onready var input_component: InputComponent = %InputComponent

func _physics_process(delta: float) -> void:
	input_component.update()
	player_movement.direction = input_component.move_dir
	player_movement.jump_pressed = input_component.jump_pressed
	player_movement.jump_released = input_component.jump_released
	player_movement.dash_pressed = input_component.dash_pressed
	player_movement.update(delta)
	
	move_and_slide()
