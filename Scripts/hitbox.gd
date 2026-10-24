class_name HitBox extends Area2D

@export var damage := 1
@export var impact := 0.5

func _ready() -> void:
	collision_layer = 16
	collision_mask = 0
