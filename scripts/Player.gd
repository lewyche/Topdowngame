extends KinematicBody2D

var velocity = Vector2()
export var speed = 10000
export var dash_multipler = 3

func _ready():
	pass # Replace with function body.

func hit():
	pass

func get_input():

	#input
	if Input.is_action_pressed("up"):
		velocity += Vector2(0,-1)
	if Input.is_action_pressed("down"):
		velocity += Vector2(0,1)
	if Input.is_action_pressed("left"):
		velocity += Vector2(-1,0)
		$Sprite.flip_h = true
	if Input.is_action_pressed("right"):
		velocity += Vector2(1,0)
		$Sprite.flip_h = false
		
	#multiply velocity for dash mechanic
	if Input.is_action_just_pressed("dash"):
		if $DashCooldown.time_left == 0:
			velocity = velocity * dash_multipler
			$DashCooldown.start()
	

func _physics_process(delta):
	
	#for smooth stopping
	velocity = Vector2(lerp(velocity.x,0,0.2), lerp(velocity.y,0,0.2))
	
	get_input()
	velocity.normalized()
	move_and_slide(velocity * speed  * delta)

func _input(event):
	pass
