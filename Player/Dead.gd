extends PlayerState

export(NodePath) var _animation
onready var animated_sprite: AnimatedSprite = get_node(_animation)

func enter(msg := {}) -> void:
	if msg.has("falling_death"):
		$falloff.play()
		yield($falloff, "finished")	
		get_tree().change_scene("res://HUD/Level Menu.tscn")
	else:
		animated_sprite.play("die")
		yield(animated_sprite, "animation_finished")	
		get_tree().change_scene("res://HUD/Level Menu.tscn")
		
func update(delta):
	if animated_sprite.get_frame() == 0:
		animated_sprite.modulate = Color(100,1,1,1)	
