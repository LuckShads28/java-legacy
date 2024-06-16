extends Node2D

@export var heal_value : int = 5

@onready var stats : PlayerStats = PlayerStats

func heal_player(value):
	stats.heal(stats.health+value)

func _on_area_2d_body_entered(body):
	if stats.health < stats.maxHealth:
		heal_player(heal_value)
		queue_free()
