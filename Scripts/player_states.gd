class_name PlayerStates extends Node

@export var player: Player


enum State {IDLE, RUN, JUMP, FALL, DASH, WALL_SLIDE}
var current_state: State = State.IDLE
var last_state: State

func change_state(new_state: State) -> void:
	last_state = current_state
	current_state = new_state

func exit_state() -> void:
	current_state = last_state
