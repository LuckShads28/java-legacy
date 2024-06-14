extends Label

@export var state_machine: CharacterStateMachine
@export var hp : Damageable = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State: " + state_machine.current_state.name
	if hp:
		text = "HP: " + str(hp.health)
