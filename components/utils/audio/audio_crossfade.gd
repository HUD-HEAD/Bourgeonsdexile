class_name AudioCrossfade
extends VisibleOnScreenNotifier2D

@export var fade_out_player : AudioStreamPlayer
@export var fade_in_player : AudioStreamPlayer

func _ready() -> void:
	screen_entered.connect(cross_fade)

func cross_fade():
	AudioManager.cross_fade(fade_out_player, fade_in_player)
