extends CharacterBody2D

@export var health_point : int = 3

@onready var spear : Sprite2D = $spear
@onready var shape : ShapeCast2D = $spear/hitcast
@onready var animia : AnimatedSprite2D = $animia
@onready var enemyfx : AnimationPlayer = $enemyfx
@onready var navig : NavigationAgent2D = $navigger
@onready var player = get_tree().get_nodes_in_group("Player")[1]
@onready var theplayer = get_tree().get_nodes_in_group("Player")[0]

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var iframe : bool = false
var move_speed = 50
var accel = 5

var die : bool = false

func _ready():
	enemyfx.play("Normal")

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
	if shape.is_colliding():
		if shape.get_collider(0) == player:
			theplayer.get_hit(1)

	var direction = Vector2() 

	navig.target_position = player.global_position

	direction = navig.get_next_path_position() - global_position
	direction = direction.normalized()

	if !die:
		velocity.x = direction.x * move_speed
		animia.play("Walk")
	elif die:
		velocity.x = 0
		velocity.y += gravity * delta

	if direction.x < 0 and !die: # <-----
		spear.scale.x = 1
		animia.scale.x = 1
	elif direction.x > 0 and !die: # ----->
		spear.scale.x = -1
		animia.scale.x = -1
	move_and_slide()

func enemy_get_hit(damage : int):
	if !iframe and !die:
		iframe = true
		enemyfx.play("Hit")
		health_point -= damage
		bounce()

		if health_point <= 0:
			enemy_die()

func enemy_die():
	die = true
	$spear/hitcast.enabled = false
	enemyfx.play("dead")
	animia.play("Dead")
	theplayer.score_up()
	$diecooldown.start()

func bounce():
	var dir = Vector2()
	dir = global_position - player.global_position 
	dir = dir.normalized()
	velocity = velocity.lerp(dir * 20, 2.3)

func _on_anim_animation_finished(anim_name):
	if anim_name == "Hit" and health_point != 0:
		enemyfx.play("Iframe")
	if anim_name == "Iframe":
		enemyfx.play("Normal")
		iframe = false

func _on_diecooldown_timeout():
	queue_free()
