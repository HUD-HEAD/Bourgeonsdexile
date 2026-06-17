extends Area2D

@export var to_disable : Node

@export_group("Sound")
@export var play_sfx: bool = false 
@export var sfx: AudioConfiguration.sfx_type = AudioConfiguration.sfx_type.puzzle_correct_piece
@export var stream: AudioStream

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(_area2d : Area2D):
	to_disable.disable()
	SignalManager.next_panel.emit()
	
	if play_sfx:
		if stream != null:
			AudioManager.play_audio_stream(stream)
		else:
			AudioManager.play_sfx(sfx)
