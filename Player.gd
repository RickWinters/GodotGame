extends KinematicBody2D

var score : int = 0
var speed : int = 20000

var vel : Vector2 = Vector2()

onready var sprite : Sprite = get_node("Sprite")

func _physics_process(_delta):
	
	if Input.is_action_pressed("move_left"):
		vel.x = -speed
	if Input.is_action_pressed("move_right"):
		vel.x = speed
	if Input.is_action_pressed("move_down"):
		vel.y = speed
	if Input.is_action_pressed("move_up"):
		vel.y = -speed
	
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false
		
	vel = vel.normalized() * speed
	vel = move_and_slide(vel)
	
