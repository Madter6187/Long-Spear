extends CanvasLayer

@onready var main = preload("res://Scene/MainMenu.tscn")

func _on_button_pressed():
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().quit()

func _on_mainmenu_pressed():
	get_tree().change_scene_to_packed(main)
