extends KinematicBody2D

# Variables
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		get_node("Player_sprite").flip_h = false	# get_node("Player_sprite")   and   $Player_sprite    work the same way until we have multiple sprites. then use get_node
		$Player_sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Player_sprite.flip_h = true
		$Player_sprite.play("Run")
	else:
		$Player_sprite.play("Idle")
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else:
		$Player_sprite.play("Jump")
	
	motion = move_and_slide(motion, UP)
	