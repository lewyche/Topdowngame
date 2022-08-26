extends "res://scripts/Character.gd"

export var walk_distance = 50

#way of measuring distance
var steps = 0
var direction = Vector2()

func _ready():
	randomize()

func die():
	queue_free()

func hit(dmg):
	if $Invincibility.time_left == 0:
		hits_taken += dmg
		$AnimationPlayer.play("Hit")
		start_invincibility()
		#induce erractic movement after being hit
		speed += 300
		walk_distance -= 15
		
	if hits_taken >= health:
		die()

func get_rand_positives(num):
	#decide randomly whether number is going to be
	#negative or positive
	#possibly change name
	var rand_num = randi() % 2
	if rand_num == 0:
		num = num * -1
	return num

#randomly pick a direction for the character to go
func get_rand_direction():
	var random = RandomNumberGenerator.new()
	var randX = rand_range(0,1)
	var randY = rand_range(0,1)
	randX = get_rand_positives(randX)
	randY = get_rand_positives(randY)
	return Vector2(randX, randY)
	
func change_direction():
	#start at 0 because steps variable is initiated at zero
	if steps == 0:
		direction = get_rand_direction()
	if steps == walk_distance:
		steps = 0
	else:
		steps += 1


func _physics_process(delta):
	change_direction()
		
	velocity = direction
	velocity = move_and_slide(velocity * speed)
