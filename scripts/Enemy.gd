extends KinematicBody2D

onready var player = get_node("../Player")

var velocity = Vector2()
export var speed = 300
export var health = 3

func _ready():
	pass # Replace with function body.
	
func hit():
	pass
	
func check_collisions(collision_info):
	if collision_info:
		var object = collision_info.get_collider()
		if object.is_in_group("Player"):
			print("hit player")
			object.hit()
		
	
func _physics_process(delta):
	var player_pos = player.position
	if position.distance_to(player_pos) <= 300:
		velocity = position.direction_to(player_pos)
	

	var collision_info = move_and_collide(velocity * speed * delta)
	check_collisions(collision_info)
