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
###
var can_input = true # for attack
var prev = null
var curr = null
###
var velocity := Vector2.ZERO
var jumps_made = 0

onready var ground_ray = get_node("ground_check_ray")

func get_input_direction() -> float:
	
	#if not can_input: #for attack
	#	return 0.0
	
	var direction = (Input.get_action_strength("move_right") 
					- Input.get_action_strength("move_left"))
	
	if direction < 0:
		$AnimatedSprite.flip_h = true
	if direction > 0: 
		$AnimatedSprite.flip_h = false
		
	return direction 
	
func on_floor() -> bool:
	if ground_ray.is_colliding():
		return true
	else:
		return false
		




func _on_AnimatedSprite_animation_finished(): #remember to disconnect me
	pass
	#prev = curr
	#curr = $AnimatedSprite.get_animation()
	
	
	
	#if prev != null and prev == "attack1":
		#can_input = true #for attack
