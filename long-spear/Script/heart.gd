extends TextureRect

@export var die : bool

@onready var fullheart = preload("res://Heart/FullHeart.png")
@onready var emtyheart = preload("res://Heart/EmtyHeart.png")

func _process(_delta):
	if die:
		texture = emtyheart
	elif !die:
		texture = fullheart
