extends RigidBody2D
class_name Enemy

@export var HP : int = 3

func _process(_delta):
	check_hp()

func get_hit():
	print("from", HP)
	HP = HP - 1
	print("to", HP)

func check_hp():
	if HP == 0:
		print("AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")

func _on_hurtarea_mouse_entered():
	get_hit()
