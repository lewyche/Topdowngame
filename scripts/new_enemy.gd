extends "res://scripts/Character.gd"

onready var player = get_node("../Player")

export var chase_range = 500
export var power = 1

func _ready():
	pass # Replace with function body.
	
func die():
	queue_free()	

func hit(dmg):
	if $Invincibility.time_left == 0:
		hits_taken += dmg
		$AnimationPlayer.play("Hit")
		start_invincibility()
		if hits_taken >= health:
			die()
	
func check_collisions():
	for i in get_slide_count():
		var collision_info = get_slide_collision(i)
		
		var object = collision_info.get_collider()
		if object.is_in_group("Player"):
			object.hit(power)
	
func _physics_process(delta):
	var player_pos = player.position
	if position.distance_to(player_pos) <= chase_range:
		velocity = position.direction_to(player_pos)
	else:
		velocity = Vector2()
	

	velocity = move_and_slide(velocity * speed)
	check_collisions()
