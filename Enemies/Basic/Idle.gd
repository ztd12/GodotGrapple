extends State

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	animated_sprite.play("idle")

	
func physics_update(delta: float) -> void:
	
	if owner.taking_damage:
		state_machine.transition_to("Takehit")
	
	if owner.dead:
		state_machine.transition_to("Death")
	
	if (owner.detected_player == true) or (owner.player_behind == true):
		state_machine.transition_to("Run")
		
	owner.velocity.x = lerp(owner.velocity.x, 0, owner.friction * delta)
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if not owner.on_floor():
		state_machine.transition_to("Fall")
		return 
		
