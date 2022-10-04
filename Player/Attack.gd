extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)


export(NodePath) var timer
onready var attack_timer = get_node(timer)

var states = ["attack1","attack2","attack3"]

var state_position



func enter(_msg := {}) -> void:
	if attack_timer.get_time_left() == 0:
		state_position = 0
		animated_sprite.play(states[state_position])
	elif attack_timer.get_time_left() != 0:
		if state_position == 2:
			state_position = 0
			animated_sprite.play(states[state_position])
		else:
			state_position += 1
			animated_sprite.play(states[state_position])
		
	
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
	
	
	if Input.is_action_just_pressed("jump") and player.on_floor():
		state_machine.transition_to("Jump")
	
	print(attack_timer.get_time_left())
	
	if (att1 or att2 or att3):
		attack_timer.start()
		state_machine.transition_to("Idle")
		
