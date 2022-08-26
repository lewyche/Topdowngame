extends Sprite


onready var bullet = preload("res://Props/bullet.tscn")

onready var world = get_node("../../../")
onready var player = get_node("../../")

export var power = 1

var rad = 100
var player_pos = Vector2()
var mouse_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_angle():
	#get angle of mouse from player
	var deltax = mouse_pos.x - player_pos.x
	var deltay = mouse_pos.y - player_pos.y
	var theta = 0
	if(deltax != 0):
		theta = atan2(deltay, deltax)
	return (theta)

func get_circle_pos(mouse_angle):
	#get position of circle from angle
	var pos = Vector2()
	pos.x = player_pos.x + rad * cos(mouse_angle)
	pos.y = player_pos.y + rad * sin(mouse_angle)
	return pos

func shoot():
	var new_bullet = bullet.instance()
	world.add_child(new_bullet)
	new_bullet.position = player.global_position
	#make bullet target the position of the mouse
	new_bullet.set_target_pos(get_global_mouse_position())
	new_bullet.set_power(power)
	

func get_input():
	if Input.is_action_just_pressed("shoot"):
		if $Cooldown.time_left == 0:
			shoot()
			$Cooldown.start()

func _process(delta):
	if player.dead == false:
		
		get_input()
		
		#get positions 
		player_pos = player.global_position
		mouse_pos = get_global_mouse_position()
		
		var mouse_angle = get_angle()
		global_position = get_circle_pos(mouse_angle)
		
		look_at(mouse_pos)
	
