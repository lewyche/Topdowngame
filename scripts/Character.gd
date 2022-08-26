extends KinematicBody2D

var velocity = Vector2()
export var speed = 300
export var health = 3

var original_health = 0

var dead = false

var hits_taken = 0

func start_invincibility():
	$Invincibility.start()
	
func hit(dmg):
	pass
	
func reset():
	pass

func die():
	pass

func ready():
	pass
	
func _physics_process(delta):
	pass
