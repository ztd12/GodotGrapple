extends State

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(_msg := {}) -> void:
	animated_sprite.play("attack")
	
func physics_update(delta: float) -> void:
	
	if owner.detected_player == true and owner.distance_to_player > 45:
		state_machine.transition_to("Run")
		
	if not owner.is_on_floor():
		state_machine.transition_to("Fall")
		return 
		
	if owner.detected_player == false:
		state_machine.transition_to("Idle")
	
