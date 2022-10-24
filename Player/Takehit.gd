extends PlayerState


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)


func enter(_msg := {}) -> void:
	animated_sprite.play("hurt")

func update(delta):
	if animated_sprite.get_frame() == 0:
		animated_sprite.modulate = Color(100,1,1,1)
	if animated_sprite.get_frame() == 2:
		animated_sprite.modulate = Color(1,1,1,1)	
	
func physics_update(delta: float) -> void:
	
	if player.dead:
		player.taking_damage = false
		state_machine.transition_to("Dead")
		
	if not player.on_floor():
		player.taking_damage = false
		state_machine.transition_to("Fall")
		return 
		
		
	player.velocity.x = lerp(player.velocity.x, 0, player.friction * delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	

	if Input.is_action_just_pressed("dodge"):
		player.taking_damage = false
		state_machine.transition_to("Dodge")
	else:
		if animated_sprite.get_frame() == 2:
			player.taking_damage = false
			state_machine.transition_to("Idle")

