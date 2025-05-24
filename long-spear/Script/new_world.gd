extends Node2D

@onready var lpoint : Vector2 = $Leftpos.position
@onready var rpoint : Vector2 = $Rightpos.position
@onready var enemys = preload("res://Scene/enemy.tscn")

var amount = [-1, 0, 1]
#	-1 = 1 at left point
#	0 = 2 at both point
#	1 = 1 at right point

func _ready():
	spawn_system()

func spawn_system():
	var enemy_remain = get_tree().get_node_count_in_group("Enemy")
	var much = amount.pick_random()
	if enemy_remain == 0:
		print(much)
		if much == -1: # 1 at left point
			var enemy = enemys.instantiate()
			enemy.position = lpoint
			add_child(enemy)
		elif much == 0: # 2 at both point
			var enemy_l = enemys.instantiate()
			enemy_l.position = lpoint
			add_child(enemy_l)
			var enemy_r = enemys.instantiate()
			enemy_r.position = rpoint
			add_child(enemy_r)
		elif much == 1: # 1 at right point
			var enemy = enemys.instantiate()
			enemy.position = rpoint
			add_child(enemy)

func _process(_delta):
	
	if Input.is_action_just_pressed("E"): #check enemy spawn
		var enemy = enemys.instantiate()
		enemy.position = lpoint
		add_child(enemy)
		#print(get_tree().get_nodes_in_group("Enemy"))

	spawn_system()
