extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

@export var starting_move_direction: Vector2 = Vector2.LEFT
@export var SPEED = 50
@export var hit_state : State

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var hit_box_collision_shape = $BiteHitbox/CollisionShape2D
@onready var player_detector_collision = $PlayerDetector/CollisionShape2D
@onready var sprite = $Sprite2D

@export var ray_cast_right : RayCast2D 
@export var ray_cast_left : RayCast2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = starting_move_direction

signal facing_direction_changed(facing_right: bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if direction && state_machine.check_if_can_move():
		if ray_cast_right.is_colliding():
			direction = Vector2.LEFT
			flip()
		if ray_cast_left.is_colliding():
			direction = Vector2.RIGHT	
			flip()
		velocity.x = direction.x * SPEED
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func flip():
	if direction == Vector2.LEFT:
		sprite.flip_h = true
		hit_box_collision_shape.position = hit_box_collision_shape.facing_left_position
		player_detector_collision.position[0] *= -1
	elif direction == Vector2.RIGHT:
		sprite.flip_h = false
		hit_box_collision_shape.position = hit_box_collision_shape.facing_right_position
		player_detector_collision.position[0] *= -1
