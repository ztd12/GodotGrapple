extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)


export(NodePath) var timer
onready var attack_timer = get_node(timer)

export var anim: String
export var next_state: String

#var action_pressed = false 

func enter(_msg := {}) -> void:
	animated_sprite.play(anim)
	#player.can_input = false
	#action_pressed = false
	
func physics_update(delta: float) -> void:
	
	var att1 := (animated_sprite.get_animation() == "attack1") and (animated_sprite.get_frame() == 4)
	var att2 := (animated_sprite.get_animation() == "attack2") and (animated_sprite.get_frame() == 5)
	var att3 := (animated_sprite.get_animation() == "attack3") and (animated_sprite.get_frame() == 5)		
	
	if player.is_on_floor():
		player.velocity.x = lerp (player.velocity.x,
								 0,
								 player.friction * delta) #player does not move when attacking
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	#if Input.is_action_just_pressed("attack"):
	#	action_pressed = true
	if next_state and Input.is_action_just_pressed("attack") and (att1 or att2 or att3):
		state_machine.transition_to(next_state)
	
	if Input.is_action_just_pressed("jump") and player.on_floor():
		state_machine.transition_to("Jump")
	
	#if  att1 or player.get_input_direction() != 0.0:#some bug
	if (att1 or att2 or att3):
		state_machine.transition_to("Idle")
		
