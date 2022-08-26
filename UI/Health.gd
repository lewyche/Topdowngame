extends Control

var upper = 0
var lower = 0

func set_health(up, low:int = lower):
	upper = up
	lower = low
	$Label.text = str(upper) + "\n - \n" + str(lower)

func set_max_health(health):
	set_health(health, health)

func _ready():
	pass # Replace with function body.

func hit(dmg):
	set_health(upper - dmg)
func heal(dmg):
	set_health(upper + dmg)
