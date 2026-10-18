class_name PlayerAnimations extends Node

@export var player: Player

func update() -> void:
	if player.player_states.current_state == player.player_states.State.RUN:
		player.sprite.play("Run") 
	elif player.player_states.current_state == player.player_states.State.IDLE:
		player.sprite.play("Idle") 
	elif player.player_states.current_state == player.player_states.State.JUMP:
		player.sprite.play("Jump")
	elif player.player_states.current_state == player.player_states.State.FALL:
		player.sprite.play("Fall") 
	elif player.player_states.current_state == player.player_states.State.WALL_SLIDE:
		player.sprite.play("WallSlide") 
