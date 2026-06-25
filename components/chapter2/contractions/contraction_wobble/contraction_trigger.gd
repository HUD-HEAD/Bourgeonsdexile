extends VisibleOnScreenNotifier2D

func _ready() -> void:
	screen_entered.connect(_on_screen_entered)


func _on_screen_entered():
	SignalManager.trigger_contraction.emit()
