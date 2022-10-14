extends Node2D

onready var rays = [$Ray80, $Ray90, $Ray100, $Ray110, $Ray120, $Ray130, $Ray140, $Ray150, $Ray160, $Ray170, $Ray180, $Ray190]
var rays_colliding_player = [false,false,false,false,false,false,false,false,false,false,false,false]

export(NodePath) var _enemyNode
onready var _enemy: KinematicBody2D = get_node(_enemyNode)

func _ready():
	for ray in rays:
		ray.add_exception(_enemy)
	
func _physics_process(delta):
	detect_player_position()
	#print(owner.detected_player, owner.player_position, owner.distance_to_player)
	
func detect_player_position():
	for i in range(len(rays)):
		var ray = rays[i]

		if ray.is_colliding():
			if ray.get_collider().name == "Player":
				owner.detected_player = true
				owner.player_position = ray.get_collider().get_global_position()
				owner.distance_to_player = owner.global_position.distance_to(owner.player_position)
				rays_colliding_player[i] = true
			else:
				rays_colliding_player[i] = false
		else:
			rays_colliding_player[i] = false
	if not rays_colliding_player.has(true):
		owner.detected_player = false
		owner.player_position = Vector2.ZERO
	
