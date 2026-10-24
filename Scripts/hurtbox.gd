class_name HurtBox extends Area2D

func _ready() -> void:
	collision_layer = 0
	collision_mask = 16
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
	
	var attacker = hitbox.owner
	var target = owner
	
	if attacker == null or target == null:
		return
	
	if attacker.is_in_group("Player") and target.is_in_group("Player"):
		return
	
	if attacker.is_in_group("Enemy") and target.is_in_group("Enemy"):
		return
	
	if owner.get_node("HealthComponent") != null:
		owner.health_component.take_dmg(hitbox.damage)
		get_tree().paused = true
		await get_tree().create_timer(hitbox.impact / 10).timeout
		get_tree().paused = false
