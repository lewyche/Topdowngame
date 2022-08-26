extends CanvasLayer


func _ready():
	pass # Replace with function body.

func hide_other_ui(curr_ui):
	#when one ui panel is opened, all other ui elements are to be hidden
	#i dont feel like thinking rn so this is the solution im using
	if curr_ui.name == $"Game Over".name:
		$Inventory.visible = false
	else:
		$"Game Over".visible = false

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		#invert visibility
		$Inventory.visible = not $Inventory.visible
		
