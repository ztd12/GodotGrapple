extends State


export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)



func enter(_msg := {}) -> void:
	animated_sprite.play("death")


func update(delta):
	if animated_sprite.get_frame() == 0:
		animated_sprite.modulate = Color(10,10,10,10)
	if animated_sprite.get_frame() == 2:
		animated_sprite.modulate = Color(1,1,1,1)	
	
func _physics_update(delta):
	
	owner.velocity.x = lerp(owner.velocity.x, 0, owner.friction * delta)
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if animated_sprite.get_frame() == 3:
		pass
		#yield(get_tree().create_timer(5), "timeout")
		#owner.queue_free() # why does the state machine continue to run after I freed it and why does the sprite not dissapear
