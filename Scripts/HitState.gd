extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State
@export var dead_animation_node : String = "dead"
@export var hit_animation_node : String = "hit"
@export var knockback_speed : int = 100
@export var return_state : State
@export var return_animation_node : String = "walk"

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_enter():
	timer.start()

func on_exit():
	character.velocity = Vector2.ZERO
	
func on_damageable_hit(node: Node, damage_amount: int, knockback_direction: Vector2):
	if damageable.health > 0:
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
		playback.travel(hit_animation_node)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)

func _on_timer_timeout():
	next_state = return_state
	if get_parent().name != "Player":
		playback.travel(return_animation_node)
