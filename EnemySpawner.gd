extends Node2D

var rand = RandomNumberGenerator.new()
var enemyscene = load("res://Enemies/Basic/BasicEnemy.tscn")
	
onready var screen_size = get_viewport().get_visible_rect().size

func _ready():
	for i in range(0,10):
		var enemy = enemyscene.instance()
		enemy.connect("tree_exited",self,"_on_Enemy_tree_exited")
		rand.randomize()
		var x = rand.randf_range(0,screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, 300)
		enemy.position.y = y 
		enemy.position.x = x
		add_child(enemy)
		
var count = 0	
var enemy_died = false
func _process(delta):
	
	if enemy_died:
		count += 1
		enemy_died = false
	
	if count >= 10:
		print("creating 10 enemies")
		for i in range(0,10):
			var enemy = enemyscene.instance()
			enemy.connect("tree_exited",self,"_on_Enemy_tree_exited")
			rand.randomize()
			var x = rand.randf_range(0,screen_size.x)
			rand.randomize()
			var y = rand.randf_range(0, 300)
			enemy.position.y = y 
			enemy.position.x = x
			add_child(enemy)
			
		count = 0
		enemy_died = false
	
func _on_Enemy_tree_exited():
	print("enemy being freed")
	enemy_died = true
	return 
	
func _on_Enemy_tree_exiting():
	print("enemy being freed")
	enemy_died = true
	return 
