class_name Player
extends KinematicBody2D

var speed = 200
var jump_impulse = 700 
var maximum_jumps := 2 
var gravity = 2500
var acceleration = 60
var friction = 20 
var air_friction = 10
var slide_speed = 500
var dodge_speed = 400

var health = 3


var  taking_damage = false

var dead = false

var MAX_SPEED = 2000

const CHAIN_PULL = 50
var chain_velocity:= Vector2.ZERO

var velocity := Vector2.ZERO
var jumps_made = 0

onready var ground_ray = get_node("ground_check_ray")
onready var ground_ray2 = get_node("ground_check_ray2")
onready var ground_ray3 = get_node("ground_check_ray3")

export(NodePath) var _hitbox_collision_shape
onready var hitbox_shape: CollisionShape2D = get_node(_hitbox_collision_shape)


func get_input_direction() -> float:
	
	#if not can_input: #for attack
	#	return 0.0
	
	var direction = (Input.get_action_strength("move_right") 
					- Input.get_action_strength("move_left"))
	
	if direction < 0:
		$AnimatedSprite.flip_h = true
		hitbox_shape.position.x = -14
	if direction > 0: 
		$AnimatedSprite.flip_h = false
		hitbox_shape.position.x = 14
		
	return direction 
	
func on_floor() -> bool:
	if (ground_ray.is_colliding() or 
		ground_ray2.is_colliding() or
		ground_ray3.is_colliding()):
		return true
	else:
		return false
		


func _on_PlayerHurtbox_area_entered(hitbox):
	if hitbox.name == "EnemyHitbox":
		self.health -= hitbox.damage
		self.dead = health < 1
		self.taking_damage = true
		print(hitbox.get_parent().name + " dealing " + str(hitbox.damage) + " to " + name, health, dead)
		
		Global.lose_life()
		

#TODO, ADD HURT ANIMATION AND MAKE TAKING DAMAGE FLAG TRANSITION TO TAKEHIT STATE FROM ANY STATE.
