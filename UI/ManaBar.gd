extends ProgressBar

@onready var timer = $Timer
@export var mana_consume : ProgressBar

@onready var stats: PlayerStats = PlayerStats

var mana = 0 : set = _set_mana
var first_init : bool = false

func _ready():
	stats.connect("manaChanged", _set_mana)

func init_mana(_mana):
	mana = _mana
	max_value = mana
	value = mana
	mana_consume.max_value = mana
	mana_consume.value = mana

func _set_mana(new_mana):
	var prev_mana = mana
	mana = min(max_value, new_mana)
	value = mana
	
	if first_init == false:
		first_init = true
		init_mana(new_mana)
	
	#if mana <= 0:
		#queue_free()
	
	if mana < prev_mana:
		timer.start()
	else:
		mana_consume.value = mana
	
func _on_timer_timeout():
	mana_consume.value = mana
