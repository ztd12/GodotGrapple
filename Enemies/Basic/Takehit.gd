extends State


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)


func enter(_msg := {}) -> void:
	animated_sprite.play("takehit")

func physics_update(delta: float) -> void:
	if owner.taking_damage:
		state_machine.transition_to("Takehit")
	owner.velocity.x = lerp(owner.velocity.x, 0, owner.friction * delta)
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	if animated_sprite.get_frame() >= 7:
		owner.taking_damage = false
		state_machine.transition_to("Idle")
