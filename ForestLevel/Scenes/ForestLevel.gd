extends Node2D

export (NodePath) var _pause_menu
onready var _pause = get_node(_pause_menu)

func _on_PauseButton_pressed():
	get_tree().paused = true
	_pause.popup()

var rand = RandomNumberGenerator.new()
var enemyscene = load("res://Enemies/Basic/BasicEnemy.tscn")
	
onready var screen_size = get_viewport().get_visible_rect().size

var num_of_enemies = 7
onready var startrange = screen_size.x
onready var endrange  = startrange*2

func enemyspawner():
	for i in range(0,num_of_enemies):
		var enemy = enemyscene.instance()
		rand.randomize()
		var x = rand.randf_range(startrange,endrange)
		rand.randomize()
		var y = rand.randf_range(0, 300)
		enemy.position.y = y 
		enemy.position.x = x
		add_child(enemy)
		enemy.add_to_group("enemies")
		

func _ready():
	Global.lives = Global.max_lives
	load_hearts()
	Global.hud = self
	enemyspawner()

func _process(delta):
	
	var count = get_tree().get_nodes_in_group("enemies").size()
	
	if count == 0:
		print("creating", num_of_enemies,  "enemies")
		for i in range(0,num_of_enemies):
			var enemy = enemyscene.instance()
			rand.randomize()
			var x = rand.randf_range(startrange,endrange)#0,screen_size.x)
			rand.randomize()
			var y = rand.randf_range(0, 300)
			enemy.position.y = y 
			enemy.position.x = x
			add_child(enemy)
			enemy.add_to_group("enemies")
			
	
func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HUD/Level Menu.tscn")

func _on_Resume_pressed():
	_pause.hide()
	get_tree().paused = false
	

func _on_Mute_pressed():
	var master_sound = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_sound,
							not AudioServer.is_bus_mute(master_sound))

func load_hearts():
	$hearts.rect_size.x = Global.lives * 600
	$unfilledhearts.rect_size.x = (Global.max_lives - Global.lives) * 305
	$unfilledhearts.rect_position.x = $hearts.rect_position.x + $hearts.rect_size.x * $hearts.rect_scale.x

	
	
