extends Control

func _ready():
	Global.lives = Global.max_lives
	load_hearts()
	Global.hud = self

#func _on_Boss_tree_exited():

func load_hearts():
	if Global.lives <= 0:
		Global.lives = 0
		$hearts.hide()
	$hearts.rect_size.x = Global.lives * 600	
	#$hearts.rect_size.x = Global.lives * 600
	#$unfilledhearts.rect_size.x = (Global.max_lives - Global.lives) * 305
	#$unfilledhearts.rect_position.x = $hearts.rect_position.x + $hearts.rect_size.x * $hearts.rect_scale.x
