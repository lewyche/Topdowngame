extends KinematicBody2D

export var speed = 10
export var max_bounces = 3
var target_pos = Vector2()
var velocity = Vector2()

var times_bounced = 0

var power = 0

func set_target_pos(pos):
	target_pos = pos
	velocity = position.direction_to(target_pos)

func set_power(powe):
	power = powe

func die():
	queue_free()

func _ready():
	pass

func check_collisions(collision_info):
	var object = collision_info.get_collider()
	
	if object.is_in_group("Npcs") or object.is_in_group("Enemy"):
		object.hit(power)
		
	velocity = velocity.bounce(collision_info.normal)
	times_bounced += 1
	#delete bullet after a certain number of bounces
	if times_bounced >= max_bounces:
		die()

func _physics_process(delta):

	var collision_info = move_and_collide(velocity * speed)
	if collision_info:
		check_collisions(collision_info)
	
	if $Lifespan.time_left == 0:
		die()
