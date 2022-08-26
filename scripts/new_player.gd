extends "res://scripts/Character.gd"

export var dash_multipler = 3
var ui_open = false

onready var game_over = get_node("../CanvasLayer/Game Over")
onready var inventory = get_node("../CanvasLayer/Inventory")
onready var player_health = get_node("../CanvasLayer/Health")

var walking = false

#shooting logic is in Gun and weapon manager nodes

func _ready():
	player_health.set_max_health(health)

#set visibility of this based on if player is alive
func set_visibility():
	game_over.visible = dead
	$Sprite.visible = not dead
	$"Weapon Manager".change_visibility(not dead)
	$CollisionShape2D.disabled = dead

func reset():
	hits_taken = 0
	dead = false
	set_visibility()
	player_health.set_max_health(health)
	
	ui_open = false
	#TODO: figure out where to respawn
	position = Vector2(0,0)

func die():
	dead = true
	print("dead")
	set_visibility()
	ui_open = true


func hit(dmg):
	if dead == false:
		#if invincible, do not take hit
		if $Invincibility.time_left == 0:
			
			print("Player hit")
			
			hits_taken += dmg 
			
			$AnimationPlayer.play("Hit")
			
			player_health.hit(dmg)
			
			start_invincibility()
			
			if hits_taken >= health:
				die()

func get_input():
	#input
	walking = false
	if Input.is_action_pressed("up"):
		velocity += Vector2(0,-1)
		walking = true
	if Input.is_action_pressed("down"):
		velocity += Vector2(0,1)
		walking = true
	if Input.is_action_pressed("left"):
		velocity += Vector2(-1,0)
		$Sprite.flip_h = true
		walking = true
	if Input.is_action_pressed("right"):
		velocity += Vector2(1,0)
		$Sprite.flip_h = false
		walking = true

	#multiply velocity for dash mechanic
	if Input.is_action_just_pressed("dash"):
		if $Cooldown.time_left == 0:
			velocity = velocity * dash_multipler
			$Cooldown.start()
	
func play_walk_sound():
	#if player is walking, play walk sound
	if $AudioStreamPlayer2D.playing:
		if walking == false:
			$AudioStreamPlayer2D.stop()
	else:
		if walking == true:
			$AudioStreamPlayer2D.play()

func _physics_process(delta):
	if dead == false:
		#for smooth stopping
		velocity = Vector2(lerp(velocity.x,0,0.2), lerp(velocity.y,0,0.2))
		
		get_input()
		play_walk_sound()
		velocity.normalized()
		move_and_slide(velocity * speed  * delta)
