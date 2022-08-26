extends "res://scripts/bullet.gd"

func check_collisions(collision_info):
	var object = collision_info.get_collider()
	
	if object.is_in_group("Npcs") or object.is_in_group("Player"):
		object.hit(power)
		
	velocity = velocity.bounce(collision_info.normal)
	times_bounced += 1
	#delete bullet after a certain number of bounces
	if times_bounced >= max_bounces:
		die()
