extends Clickable

## Amount coin fills in progress bar, between 0 and 100
@export var value : float = 5.0
@export var progress_bar : TextureProgressBar

func _action_on_click():
	super()
	
	progress_bar.value += value
	hide()
