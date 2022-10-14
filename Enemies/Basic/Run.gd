extends State


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

var direction 

func enter(_msg := {}) -> void:
	animated_sprite.play("run")
	
func physics_update(delta: float) -> void:
	if owner.distance_to_player < 45:
		state_machine.transition_to("Attack")
	if owner.player_position.x < owner.position.x:
		direction = -1
	elif owner.player_position.x > owner.position.x:
		direction = 1
		
	owner.velocity.x = direction * owner.speed 
	owner.velocity.y = owner.gravity * delta 
	owner. velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	owner.get_direction()
	
	if owner.detected_player == false:
		state_machine.transition_to("Idle")
