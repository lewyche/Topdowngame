extends Node

onready var item = preload("res://Items/Item.tscn")
var current_gun 

func set_current_gun():
	if is_gun_equipped():
		for i in get_children():
			current_gun = i

func _ready():
	set_current_gun()

func is_gun_equipped():
	if get_child_count() >= 1:
		return true
	else:
		return false

func drop_existing_gun():
	if is_gun_equipped():
		var new_item = item.instance()
		new_item.initalize_item(current_gun.name, true,current_gun.texture,get_parent().position)
		get_node("../../").add_child(new_item)
		current_gun.queue_free()

func pick_up_weapon(item):
	var weapon = load("res://Weapons/" + item.item_type + ".tscn")
	if weapon:
		var new_weapon = weapon.instance()
		drop_existing_gun()
		add_child(new_weapon)
		set_current_gun()
	else:
		print("didn't work")

func change_visibility(visible):
	current_gun.visible = visible
