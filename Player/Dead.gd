extends PlayerState



func enter(_msg := {}) -> void:
	$falloff.play()
	yield($falloff, "finished")	
	get_tree().change_scene("res://HUD/Level Menu.tscn")
