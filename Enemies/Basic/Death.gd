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
