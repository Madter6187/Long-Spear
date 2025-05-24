extends Node2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var heart = preload("res://Scene/heart.tscn")
#@onready var died_ui = preload("res://died screen.tscn").instantiate()
@onready var enemy = get_tree().get_nodes_in_group("Enemy")

@export var Health_Point : int = 3
@export var score : int = 0
@export var player : RigidBody2D
@export var spear : RigidBody2D
@export var spearshape : ShapeCast2D
@export var anima : AnimatedSprite2D
@export var player_fx : AnimationPlayer
@export var spearanim : AnimationPlayer
@export var hearttray : GridContainer

var move_speed = 175
var jump_force = -500
var iframe : bool = false
var die : bool = false
var healing : bool = false
var healing_duration = 4
var healing_elapsed = 0.0

func _ready():
	player_fx.play("Normal")
	spearanim.play("SpearIdle")
	initial_heart()

func _process(delta):
	side()
	spearing()
	healing_factor()
	if Input.is_action_just_pressed("Space"):
		spearanim.play("SpearLonging")
	if healing:
		healing_elapsed += delta
		var progress = (healing_elapsed / healing_duration) * 100.0
		$Player/healingbar.value = clamp(progress, 0, 100)

func moving():
	var AD = Input.get_axis("move_left", "move_right")
	if AD > 0 and !die:
		player.linear_velocity.x = move_speed
		anima.play("Walk")
	elif AD < 0 and !die:
		player.linear_velocity.x = -move_speed
		anima.play("Walk")
	elif !die:
		player.linear_velocity.x = 0
		anima.play("Idle")

func side():
	var AD = Input.get_axis("move_left", "move_right")
	if AD > 0 and !die:
		anima.flip_h = false
	elif AD < 0 and !die:
		anima.flip_h = true

func swing():
	var turning = Input.get_axis("turn_anti_clock", "turn_clock")

	if turning > 0 and !die: # --->
		spear.angular_velocity = 5
	elif turning < 0 and !die: # <---
		spear.angular_velocity = -5
	elif !die:
		spear.angular_velocity = 0

func spearing():
	if spearshape.is_colliding():
		if spearshape.get_collider(0) != null:
			spearshape.get_collider(0).enemy_get_hit(1)

func initial_heart():
	for i in range(Health_Point):
		var TheHeart = heart.instantiate()
		hearttray.add_child(TheHeart)

func get_hit(damage : int):
	if !iframe and !die:
		player.linear_velocity.x = 0
		player.apply_central_impulse(Vector2(0, -150))
		Health_Point -= damage
		iframe = true
		player_fx.play("Hit")
		heart_update()
		if Health_Point <= 0:
			player_die()

func heart_update():
	if Health_Point == 3:
		hearttray.get_child(2).die = false
		hearttray.get_child(1).die = false
		hearttray.get_child(0).die = false
	if Health_Point == 2:
		hearttray.get_child(2).die = true
		hearttray.get_child(1).die = false
		hearttray.get_child(0).die = false
	elif Health_Point == 1:
		hearttray.get_child(2).die = true
		hearttray.get_child(1).die = true
		hearttray.get_child(0).die = false
	elif Health_Point <= 0:
		hearttray.get_child(2).die = true
		hearttray.get_child(1).die = true
		hearttray.get_child(0).die = true

func player_die():
	die = true
	spearshape.enabled = false
	anima.play("Dead")
	player_fx.play("Dead")
	$died.visible = true

func score_up():
	score += 1
	$Player/score.text = str(score)

func healing_factor():
	if Health_Point < 3 and not healing:
		healing = true
		healing_elapsed = 0.0
		$healingtime.start(healing_duration)
		$Player/healingbar.visible = true
		$Player/healingbar.value = 0

func _physics_process(_delta):

	if Input.is_action_pressed("move_up"):
		player.linear_velocity.y = -100

	swing()
	moving()

func _on_playeranim_animation_finished(anim_name):
	if anim_name == "Hit" and Health_Point != 0:
		player_fx.play("Iframe")
	if anim_name == "Iframe":
		player_fx.play("Normal")
		iframe = false

func _on_healingtime_timeout():
	Health_Point += 1
	heart_update()
	healing = false
	$Player/healingbar.visible = false
	print(Health_Point)
