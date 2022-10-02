class_name Player
extends KinematicBody2D

var speed = 200
var jump_impulse = 600 
var double_jump = 600
var maximum_jumps := 2 #
var gravity = 2500
var acceleration = 60
var friction = 20 
var air_friction = 10 

var velocity := Vector2.ZERO
var jumps_made = 0

onready var ground_ray = get_node("")

func get_input_direction() -> float:
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction < 0:
		$AnimatedSprite.flip_h = true
	if direction > 0: 
		$AnimatedSprite.flip_h = false
		
	return direction 
	
func on_ground() -> bool:
	if ground_ray.is_colliding():
		return true
	else:
		return false
