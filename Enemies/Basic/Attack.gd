extends State

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

export(NodePath) var _hitbox
onready var hitbox: Area2D = get_node(_hitbox)

func enter(_msg := {}) -> void:
	if owner.distance_to_player == 9999:
		state_machine.transition_to("Idle")
	animated_sprite.play("attack")
	
func update(delta):
	if animated_sprite.get_frame() == 3:
		animated_sprite.modulate = Color(100,1,1,50)
		yield(get_tree().create_timer(.3), "timeout")
	if animated_sprite.get_frame() > 4:
		animated_sprite.modulate = Color(1,1,1,1)		
	
func physics_update(delta: float) -> void:
	if owner.taking_damage:
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Takehit")
	if owner.dead:
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Death")
		
	if animated_sprite.get_frame() == 5:
		hitbox.monitorable = true
	
	if animated_sprite.get_frame() == 7:
		hitbox.monitorable = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Idle")
	
	if owner.detected_player == true and owner.distance_to_player > 55:
		hitbox.monitorable = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Run")
		
	if not owner.is_on_floor():
		hitbox.monitorable = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Fall")
		return 
		
	if owner.detected_player == false:
		hitbox.monitorable = false
		animated_sprite.modulate = Color(1,1,1,1)
		state_machine.transition_to("Idle")
	
