extends Node2D

@onready var stats = PlayerStats
@export var mana_regen_value : int = 10

func regen_mana(value):
	stats.addMana(value)

func _on_area_2d_body_entered(body):
	if stats.mana < stats.maxMana:
		regen_mana(stats.mana+mana_regen_value)
		queue_free()
