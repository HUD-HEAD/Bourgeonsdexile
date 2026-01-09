extends TextureButton

func _ready() -> void:
	SignalManager.show_next_button.connect(show)
	hide()

func _pressed() -> void:
	SignalManager.next_panel.emit()
	hide()
