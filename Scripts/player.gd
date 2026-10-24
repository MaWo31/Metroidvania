class_name Player extends CharacterBody2D

@onready var player_movement: PlayerMovement = %PlayerMovement
@onready var input_component: InputComponent = %InputComponent
@onready var player_states: PlayerStates = %PlayerStates
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_animations: PlayerAnimations = %PlayerAnimations
@onready var health_component: HealthComponent = $HealthComponent
@onready var attack1: CollisionShape2D = $Attacks/Attack1/CollisionShape2D
@onready var attacks: Node2D = $Attacks
@onready var slash: AnimatedSprite2D = $Attacks/Slash

func _ready() -> void:
	health_component.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	input_component.update()
	player_movement.direction = input_component.move_dir
	player_movement.jump_pressed = input_component.jump_pressed
	player_movement.jump_released = input_component.jump_released
	player_movement.dash_pressed = input_component.dash_pressed
	player_movement.update(delta)
	player_animations.update()
	
	move_and_slide()
	
	if input_component.attack_pressed:
		attack()

func _on_died():
	print("ded")

func attack():
	var attack_dir = input_component.attack_dir
	if abs(attack_dir.x) > abs(attack_dir.y):
		attack_dir = Vector2(sign(attack_dir.x), 0)
	else:
		attack_dir = Vector2(0, sign(attack_dir.y))
	if attack_dir == Vector2.ZERO:
		attack_dir = Vector2(player_movement.facing_dir, 0)
	attacks.rotation = attack_dir.angle()
	attack1.disabled = false
	slash.visible = true
	slash.play("S1")
	await get_tree().create_timer(0.4).timeout
	attack1.disabled = true
	slash.visible = false
