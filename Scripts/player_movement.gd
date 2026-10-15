class_name PlayerMovement extends Node


@export var body: Player
@export var jump_buffer: Timer
@export var dash_cd: Timer
@export var coyote_time: Timer

@export var speed :=  900.0
@export var acceleration := 10000.0
@export var air_acceleration := 4000.0
@export var friction := 16000
@export var air_friction := 8000.0


@export var jump_force := 1300.0
@export var gravity := 2000.0
@export var down_gravity_force = 3.0
@export var jump_cut := 5.0

@export var dash_speed := 2000
var dash_dir := 0.0
var is_dashing := false
var delta_dash := 0.0

var direction := 0.0
var jump_pressed := false
var jump_released := false
var dash_pressed := false

var facing_dir := 1

func update(delta) -> void:
	if is_dashing:
			body.velocity.x = dash_dir * dash_speed
			body.velocity.y = 0.0
			delta_dash += abs(dash_speed) * delta
			if delta_dash >= 512.0:
				body.velocity.x = speed * dash_dir
				is_dashing = false
				dash_cd.start()
			return
	
	if body.is_on_floor() and dash_cd.time_left <= 0.5:
		dash_cd.stop()
	if dash_pressed and dash_cd.is_stopped():
		dash()
		
	if direction != 0:
		facing_dir = sign(direction)
	
	var target_speed = direction * speed
	var accel := 0.0
	var current_friction := 0.0
	if direction != 0:
		if body.is_on_floor():
			accel = acceleration
		else:
			accel = air_acceleration
		body.velocity.x = move_toward(body.velocity.x, target_speed, accel * delta)
	else:
		if body.is_on_floor():
			current_friction = friction
		else:
			current_friction = air_friction
		body.velocity.x = move_toward(body.velocity.x, 0.0, current_friction * delta)
	
	if jump_pressed:
		jump_buffer.start()
	if body.is_on_floor():
		coyote_time.start()
	print(coyote_time.time_left)
	if not jump_buffer.is_stopped() and not coyote_time.is_stopped():
		body.velocity.y = -jump_force
		jump_buffer.stop()
		coyote_time.stop()
	if jump_released and body.velocity.y < 0:
		body.velocity.y *= 0.2

	if not body.is_on_floor() and body.velocity.y <= 0:
		body.velocity.y += gravity * delta
	elif body.velocity.y >= 0 and not body.is_on_floor():
		body.velocity.y += gravity * down_gravity_force * delta

func dash() -> void:
	dash_dir = facing_dir
	delta_dash = 0.0
	is_dashing = true
