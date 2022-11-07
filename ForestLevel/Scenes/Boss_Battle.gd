extends Node2D


func _ready():
	pass
	
	

func _on_Boss_tree_exited():
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://HUD/Game Won.tscn")
