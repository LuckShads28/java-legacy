extends State

@export var return_state : State
@export var return_animation_node : String = "move"
@export var skill_animation_name : String = "skill"

@onready var stats = PlayerStats
@onready var timer = $SkillCooldown
@onready var slash_skill = load("res://Player/player_slash_skill.tscn")
@onready var skill_marker = $"../../SkillMarker"
@onready var main = get_tree().get_root().get_node("Stage")

@export var skillManaConsume : int = 10
@export var mana : int = 50 :
	get:
		stats.setMana(mana)
		return mana
	set(value):
		mana = value
		stats.setMana(mana)

func _ready():
	stats.setMaxMana(mana)
	stats.connect("useManaPot", manaChange)

func manaChange(value):
	mana = value

func state_input(event: InputEvent):
	if event.is_action_pressed("skill") && timer.is_stopped():
		timer.start()
		

func shoot_skill():
	var instance = slash_skill.instantiate()
	instance.dir = skill_marker.rotation
	instance.spawn_position = skill_marker.global_position
	instance.spawn_rotation = skill_marker.global_rotation
	main.add_child.call_deferred(instance)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == skill_animation_name:
		if mana > 0:
			mana -= skillManaConsume
			shoot_skill()
		else:
			pass
		playback.travel(return_animation_node)
		next_state = return_state


func _on_animation_tree_animation_started(anim_name):
	pass
