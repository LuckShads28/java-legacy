extends State

@export var return_state : State
@export var playerDetector : Area2D
@export var attack_animation : String = "attack"
@export var return_animation_node : String = "move"

@onready var timer : Timer = $Timer

func on_enter():
	timer.start()
	attack()
	
func on_exit():
	pass

func attack():
	playback.travel(attack_animation)

func _on_timer_timeout():
	playback.travel(return_animation_node)
	next_state = return_state
