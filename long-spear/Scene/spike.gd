extends StaticBody2D

@onready var theplayer = get_tree().get_nodes_in_group("Player")[0]
@onready var player = get_tree().get_nodes_in_group("Player")[1]
@onready var spike = $spiking

func _process(_delta):
	var enemy = get_tree().get_nodes_in_group("Enemy")
	if spike.is_colliding():
		if spike.get_collider(0) != null:
			if spike.get_collider(0) == player:
				theplayer.get_hit(1000)
			elif spike.get_collider(0) == enemy[0]:
				spike.get_collider(0).enemy_get_hit(1000)
			elif spike.get_collider(0) == enemy[1]:
				spike.get_collider(0).enemy_get_hit(1000)
