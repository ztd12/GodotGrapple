extends KinematicBody2D


var speed = 150
#var jump_impulse = 700 
#var maximum_jumps := 2 
var gravity = 2500
var acceleration = 60
var friction = 20 
var air_friction = 10

var health = 100

var dead:bool = health < 1

#var slide_speed = 500
#var dodge_speed = 400

#var MAX_SPEED = 2000

#const CHAIN_PULL = 50
#var chain_velocity:= Vector2.ZERO

var velocity := Vector2.ZERO
#var jumps_made = 0

var player_behind = false
var detected_player = false
var player_position = Vector2.ZERO
var distance_to_player = Vector2.ZERO

var taking_damage = false

export(NodePath) var _hitbox_collision_shape
onready var hitbox_shape: CollisionShape2D = get_node(_hitbox_collision_shape)

func set_direction() -> float:
	
	var direction = velocity.x
	
	if direction < 0:
		$AnimatedSprite.flip_h = true
		$Vision.rotation_degrees = 0
		$RayFloorEdge.position.x = -10
		$behindRay.position.y = 9
		$behindRay.rotation_degrees = -90
		hitbox_shape.rotation_degrees = 68.2
		
	if direction > 0: 
		$AnimatedSprite.flip_h = false
		$Vision.rotation_degrees = 90
		$RayFloorEdge.position.x = 9
		$behindRay.position.y = 9
		$behindRay.rotation_degrees = 90
		hitbox_shape.rotation_degrees = 116.8
		
	return direction 

func _ready():
	pass

#ADD FLOOR Edge DETETCTION, HIT AND HURT BOXES, KNOCKBACK, BEHIND RAYCAST FUNCTION


func _on_EnemyHurtbox_area_entered(hitbox):
	if hitbox.name == "PlayerHitbox":
		self.health -= hitbox.damage
		self.taking_damage = true
		self.dead = health < 1
		print(hitbox.get_parent().name + " dealing " + str(hitbox.damage) + " to " + name, health, dead)
