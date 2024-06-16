extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int)

@export var health_bar : HealthBar = null
@onready var stats = PlayerStats

@export var health : int = 20 :
	get:
		if get_parent().name == "Player":
			stats.setHealth(health)
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
		if get_parent().name == "Player":
			stats.setHealth(health)
		
@export var dead_animation_name : String = "dead"

func _ready():
	if health_bar:
		health_bar.init_health(health)
	if get_parent().name == "Player":
		stats.setMaxHealth(health)
		stats.connect("healed", heal)

func heal(value):
	health = value

func hit(damage: int, knockback_direction: Vector2):
	health -= damage
	
	if health_bar && is_instance_valid(health_bar):
		health_bar.health = health
		
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == dead_animation_name:
		get_parent().queue_free()
