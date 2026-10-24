class_name HealthComponent extends Node

signal died
signal health_changed

@export var max_health := 2.0

var health := 0.0

func _ready() -> void:
	health = max_health

func take_dmg(amount):
	health -= amount
	clamp(health, 0, max_health)
	print(owner, " ouch")
	if health == 0:
		died.emit()
	health_changed.emit()

func heal(amount):
	health += amount
	clamp(health, 0, max_health)
	health_changed.emit()
