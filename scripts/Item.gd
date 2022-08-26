extends Area2D

export var item_type = "placeholder"
export var is_weapon = false

var pick_up_mode = false
onready var inventory = get_node("../CanvasLayer/Inventory")
onready var identifier = get_node("../CanvasLayer/Pick up identifier/Label")


func _ready():
	pass # Replace with function body.


func initalize_item(type, weapon,texture, pos):
	item_type = type
	is_weapon = weapon
	$Sprite.texture = texture
	position = pos

func _on_Item_body_entered(body):
	if body.is_in_group("Player"):
		pick_up_mode = true
		print("balls")
		identifier.visible = true


func _on_Item_body_exited(body):
	if body.is_in_group("Player"):
		pick_up_mode = false
		identifier.visible = false
		
func _process(delta):
	if Input.is_action_just_pressed("pick up"):
		if pick_up_mode == true:
			inventory.pick_up_item(self)
			queue_free()
