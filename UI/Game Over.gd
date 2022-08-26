extends Control

onready var player = get_node("../../Player")

func _ready():
	pass # Replace with function body.


func _on_Reset_pressed():
	player.reset()


func _on_Quit_pressed():
	get_tree().quit()
