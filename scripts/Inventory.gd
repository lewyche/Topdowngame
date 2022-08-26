extends Node

onready var item_list = get_node("HBoxContainer/ScrollContainer/Item_list")
onready var player = get_node("../../Player/")
var items = []


func _ready():
	pass # Replace with function body.

func add_item_to_inventory(item):
	var new_button = Button.new()
	new_button.text = item.item_type
	item_list.add_child(new_button)

func pick_up_item(item):
	if item.is_weapon == true:
		player.get_node("Weapon Manager").pick_up_weapon(item)
	else:
		add_item_to_inventory(item)
