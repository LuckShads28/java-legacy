extends ProgressBar

@export var stats = PlayerStats

func _ready():
	stats.connect("healthChanged", update)
	update()

func update():
	print("updating")
	value = stats.health * 100 / stats.maxHealth
