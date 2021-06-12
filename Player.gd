extends KinematicBody2D

signal Player_is_moving(is_moving)

var speed : int = 200
var factor : float = 0.2
var speedCutoff : float = 1
var vel : Vector2 = Vector2()


onready var sprite : Sprite = get_node("Sprite")

func update_speed(vel : Vector2):
	vel.x = vel.x * (1-factor)
	vel.y = vel.y * (1-factor)
	
	if abs(vel.x) < speedCutoff:
		vel.x = 0
	if abs(vel.y) < speedCutoff:
		vel.y = 0
	
	return vel

func send_moving_signal():
	if abs(vel.x) > 0 or abs(vel.y) > 0:
		emit_signal("Player_is_moving", true)
	else:
		emit_signal("Player_is_moving", false)

func _physics_process(_delta):
	
	if abs(vel.x) == 0 and abs(vel.y) == 0:
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
		
	vel = move_and_slide(vel)
	vel = update_speed(vel)
	send_moving_signal()
