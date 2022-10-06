extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hk
onready var grppl: Node2D = get_node(_hk)

func enter(_msg := {}) -> void:
	animated_sprite.play("idle")
	player.jumps_made = 0
	
func physics_update(delta: float) -> void:
	
		
	if not player.on_floor():
		state_machine.transition_to("Fall")
		return 
		
		
	player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dodge"):
		state_machine.transition_to("Dodge")
	elif not is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("grapple"):
		
		grppl.shoot(player.get_local_mouse_position())
		state_machine.transition_to("Hook")
		
	#if you want to use different idle animations depending on the state you can send a bool, line 
	#it was done before with air state: {prev_state = "Run"}
	
	#ex: 
	#In some state:
	#if Input.is_action_just_pressed("move_up"):
	#	state_machine.transition_to("Air", {do_jump = true})
	
	#in air state:
	#func enter(msg := {}) -> void:
	#	if msg.has("do_jump"):
	#		player.velocity.y = -player.jump_impulse
 
		

