extends KinematicBody2D


var speed = 150
#var jump_impulse = 700 
#var maximum_jumps := 2 
var gravity = 2500
var acceleration = 60
var friction = 20 
var air_friction = 10

var knockback_x = 20
var knockback_y = 10
var threat_position = 0

var health = 1

var dead:bool = health <= 0

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
var distance_to_player = 9999

var taking_damage = false

export(NodePath) var _hitbox_collision_shape
onready var hitbox_shape: CollisionShape2D = get_node(_hitbox_collision_shape)

onready var ground_ray = get_node("ground_check_ray")
onready var ground_ray2 = get_node("ground_check_ray2")
onready var ground_ray3 = get_node("ground_check_ray3")

var starting_directions = [-1,1]

func _ready():
	var starting_direction = starting_directions[randi() % starting_directions.size()]
	if starting_direction < 0:
		$AnimatedSprite.flip_h = true
		$Vision.rotation_degrees = 0
		$behindRay.position.y = 9
		$behindRay.rotation_degrees = -90
		hitbox_shape.rotation_degrees = 68.2
	elif starting_direction > 0: 
		$AnimatedSprite.flip_h = false
		$Vision.rotation_degrees = 90
		$behindRay.position.y = 9
		$behindRay.rotation_degrees = 90
		hitbox_shape.rotation_degrees = 116.8

func set_direction() -> float:
	
	var direction = velocity.x
	
	if direction < 0:
		$AnimatedSprite.flip_h = true
		$Vision.rotation_degrees = 0
		$behindRay.position.y = 9
		$behindRay.rotation_degrees = -90
		hitbox_shape.rotation_degrees = 68.2
		
	if direction > 0: 
		$AnimatedSprite.flip_h = false
		$Vision.rotation_degrees = 90
		$behindRay.position.y = 9
		$behindRay.rotation_degrees = 90
		hitbox_shape.rotation_degrees = 116.8
		
	return direction 


# HIT AND HURT BOXES, KNOCKBACK, BEHIND RAYCAST FUNCTION
func on_floor() -> bool:
	if (ground_ray.is_colliding() or 
		ground_ray2.is_colliding() or
		ground_ray3.is_colliding()):
		return true
	else:
		return false

func _on_EnemyHurtbox_area_entered(hitbox):
	$enemyHurtAudio.play()
	if hitbox.name == "PlayerHitbox" or hitbox.name == "PlayerHitbox2":
		if hitbox.name == "PlayerHitbox2":
			self.knockback_x *= 10
		self.health -= hitbox.damage
		self.taking_damage = true
		self.dead = health <= 0
		print(hitbox.get_parent().name + " dealing " + str(hitbox.damage) + " to " + name,"health: ",health,"dead: ", dead)
		
		self.threat_position = hitbox.global_position.x
		#print(self.position.x,"  enemy: ", hitbox.global_position.x)

#there is bug in death
