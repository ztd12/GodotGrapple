extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	print(player.hit_counter)
	animated_sprite.play("hurt")
	animated_sprite.modulate = Color(100,1,1,1)
	
func setup_exit():
	player.taking_damage = false
	player.hit_counter = 0
	animated_sprite.modulate = Color(1,1,1,1)	
	
func physics_update(_delta: float) -> void:
	
	if player.hit_counter > 1: #test, might remove this if it doesnt fix bug
		print("YOU HAVE BEEN HIT MORE THAN ONCE VERY FAST")
		#setup_exit()
		#state_machine.transition_to("Idle")

	if animated_sprite.get_frame() == 3:
		setup_exit()
		state_machine.transition_to("Idle")
	
	if player.dead:
		setup_exit()
		state_machine.transition_to("Dead")
	
	if player.position.x < player.threat_position:	
		player.velocity.x = player.velocity.x-(player.knockback_force*4.8) #lerp(player.velocity.x, player.velocity.x-(player.knockback_force*3.8), 0.2)
	elif player.position.x >= player.threat_position:
		player.velocity.x = player.velocity.x+(player.knockback_force*4.8)#lerp(player.velocity.x, player.velocity.x+(player.knockback_force*3.8), 0.2)
	player.velocity.y -= player.knockback_force
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)	
	
	if Input.is_action_just_pressed("dodge"):
		setup_exit()
		state_machine.transition_to("Dodge")
	

