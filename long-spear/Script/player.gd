extends CharacterBody2D
class_name Player


@export var move_speed : = 100
@export var jump_force : = 225
@export var pivot : Marker2D

@onready var anima : AnimatedSprite2D = $Anima
@onready var spear = $Spear
@onready var grav_current : Label = $gravity_current
@onready var mass_current : Label = $mass_current

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var spear_center = Vector2i(0, -30)
var spear_torque := 30000
var spear_angle = 0
var spear_speed := 2
var can_rotate : bool

func _ready():
	print(spear)

func _process(_delta):
	move_anim()
	grav_current.text = str(spear.gravity_scale)
	mass_current.text = str(spear.mass)
	_grav_mass()
func _grav_mass():
	
	var grav_sys = Input.get_axis("down_grav", "up_grav")
	var mass_sys = Input.get_axis("down_mass", "up_mass")
	
	if grav_sys:
		match grav_sys:
			1.0:
				print("grav_up")
			-1.0:
				print("grav_down")
	if mass_sys:
		match mass_sys:
			1.0:
				print("mass_up")
			-1.0:
				print("mass_down")

func spearing():
	pass
	var turning = Input.get_axis("turn_anti_clock", "turn_clock")
	if turning > 0:
		spear.constant_torque = 200000
	elif turning < 0:
		spear.constant_torque = -200000
	else:
		spear.constant_torque = 0

func move_anim():
	var AD = Input.get_axis("move_left", "move_right")
	
	if AD:
		anima.play("Walk")
		if AD > 0:
			anima.scale.x = 1
		elif AD < 0:
			anima.scale.x = -1
	else:
		anima.play("Idle")

func moving():
	var AD = Input.get_axis("move_left", "move_right")
	if AD:
		velocity.x = AD * move_speed
	else:
		velocity.x = move_toward(AD, 0, move_speed)

func _physics_process(delta):
	
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y -= jump_force
		else:
			velocity.y = 0

	spearing()
	moving()
	move_and_slide()
