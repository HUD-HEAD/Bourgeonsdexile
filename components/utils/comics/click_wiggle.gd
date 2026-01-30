extends Clickable

const AMPLITUDE : float = 2
const PERIOD : float = 0.2
const WIGGLES_NO : int = 4

func _action_on_click():
	super()
	_wiggle()
	
	
func _wiggle():
	var tween : Tween = get_tree().create_tween()
	for i in WIGGLES_NO:
		var _sign = -1 if i%2 else 1
		tween.tween_property(self, "rotation_degrees", AMPLITUDE*_sign, PERIOD)
	
	tween.tween_property(self, "rotation_degrees", 0, PERIOD)
