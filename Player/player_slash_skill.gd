extends CharacterBody2D

@export var SPEED = 100
@export var damage = 10

var dir: float
var spawn_position : Vector2
var spawn_rotation : float

@onready var animation = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D

func _ready():
	global_position = spawn_position
	global_rotation = spawn_rotation
	
	animation.play("default")
	audio.playing = true
		
func _physics_process(delta):
	velocity = Vector2(SPEED, 0).rotated(dir)
	move_and_slide()

func _on_area_2d_body_entered(body):
	print(body.name)
	for child in body.get_children():
		if child is Damageable:
			# get damage direction
			var damage_direction = (body.global_position - get_parent().global_position)
			var direction_sign = sign(damage_direction.x)
			
			if direction_sign > 0:
				child.hit(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)
	queue_free()
