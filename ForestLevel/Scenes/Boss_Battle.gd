extends Node2D


func _ready():
	Global.lives = Global.max_lives
	load_hearts()
	Global.hud = self

#func _on_Boss_tree_exited():

func load_hearts():
	$hearts.rect_size.x = Global.lives * 600
	$unfilledhearts.rect_size.x = (Global.max_lives - Global.lives) * 305
	$unfilledhearts.rect_position.x = $hearts.rect_position.x + $hearts.rect_size.x * $hearts.rect_scale.x


func _on_Node2D_child_exiting_tree(node):
	if node.name == "Boss" or node.name == "Bossman":
		yield(get_tree().create_timer(3), "timeout")
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://HUD/Game Won.tscn")	
