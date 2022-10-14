extends KinematicBody2D


var speed = 195
#var jump_impulse = 700 
#var maximum_jumps := 2 
var gravity = 2500
var acceleration = 60
var friction = 20 
var air_friction = 10

var health = 100

#var slide_speed = 500
#var dodge_speed = 400

#var MAX_SPEED = 2000

#const CHAIN_PULL = 50
#var chain_velocity:= Vector2.ZERO

var velocity := Vector2.ZERO
#var jumps_made = 0

var detected_player = false
var player_position = Vector2.ZERO
var distance_to_player = Vector2.ZERO

func get_direction() -> float:
	
	var direction = velocity.x
	
	if direction < 0:
		$AnimatedSprite.flip_h = true
		$Vision.rotation_degrees = 0
		$RayFloorEdge.position.x = -10
		$behind.position.y = 9
		$behind.rotation_degrees = -90
		
	if direction > 0: 
		$AnimatedSprite.flip_h = false
		$Vision.rotation_degrees = 90
		$RayFloorEdge.position.x = 9
		$behind.position.y = 9
		$behind.rotation_degrees = 90
		
	return direction 

func _ready():
	pass

#ADD FLOOR DETETCTION, HIT AND HURT BOXES, KNOCKBACK, BEHIND RAYCAST FUNCTION
