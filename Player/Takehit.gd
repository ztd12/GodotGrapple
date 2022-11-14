extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	animated_sprite.play("hurt")
	animated_sprite.modulate = Color(100,1,1,1)
	
func physics_update(_delta: float) -> void:

	if animated_sprite.get_frame() == 3:
		player.taking_damage = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Idle")
	
	if player.dead:
		player.taking_damage = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Dead")
	
	if player.position.x < player.threat_position:	
		player.velocity.x = player.velocity.x-(player.knockback_force*4.8) #lerp(player.velocity.x, player.velocity.x-(player.knockback_force*3.8), 0.2)
	elif player.position.x >= player.threat_position:
		player.velocity.x = player.velocity.x+(player.knockback_force*4.8)#lerp(player.velocity.x, player.velocity.x+(player.knockback_force*3.8), 0.2)
	player.velocity.y -= player.knockback_force
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)	
	
	if Input.is_action_just_pressed("dodge"):
		player.taking_damage = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Dodge")
	


