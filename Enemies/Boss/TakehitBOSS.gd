extends State


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)



func enter(_msg := {}) -> void:
	#mytimer.start()
	animated_sprite.play("takehit")
	$death_sound2.play()
	

func physics_update(_delta: float) -> void:
	
	#print(mytimer.time_left)
	#if mytimer.is_stopped():
	if animated_sprite.get_frame() == 3:
		owner.taking_damage = false
		state_machine.transition_to("Idle")	
	
	if owner.taking_damage:
		state_machine.transition_to("Takehit")
		
	if owner.dead:
		state_machine.transition_to("Death")
		
	#if owner.position.x <= owner.threat_position:	
		#owner.velocity.x = owner.velocity.x - owner.knockback_x#lerp(owner.velocity.x, owner.velocity.x-owner.knockback_x, 0.2)
	#elif owner.position.x >= owner.threat_position:
		#owner.velocity.x = owner.velocity.x + owner.knockback_x#lerp(owner.velocity.x, owner.velocity.x+owner.knockback_x, 0.2)
		#owner.velocity.y -= owner.knockback_y
	#owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)	
	
	

