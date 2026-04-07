class_name AudioZoneFade
extends VisibleOnScreenNotifier2D

@export var player : AudioStreamPlayer


func _ready() -> void:
	self.screen_entered.connect(fade_in)
	self.screen_exited.connect(fade_out)

func fade_out():
	AudioManager.fade_out(player)

func fade_in():
	AudioManager.fade_in(player)
