extends "res://scripts/Character.gd"

onready var player = get_node("../Player")
onready var bullet = preload("res://Props/enemy_bullet.tscn")

export var power = 1

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
			
func check_player_range(player_pos):
	if position.distance_to(player_pos) > 1000:
		return false
	return true
			
func shoot(player_pos):
	if $Shooting_cooldown.time_left == 0:
		if check_player_range(player_pos):
			var new_bullet = bullet.instance()
			
			new_bullet.position = position + position.direction_to(player_pos) * 50
			
			new_bullet.set_target_pos(player_pos)
			new_bullet.set_power(power)
			get_parent().add_child(new_bullet)
			$Shooting_cooldown.start()
func _physics_process(delta):
	var player_pos = player.position
	shoot(player_pos)
	check_collisions()
	
