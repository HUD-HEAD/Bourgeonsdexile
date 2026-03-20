extends Node


var audio_ambient : AudioStreamPlayer
var audio_sfx : AudioStreamPlayer
var audio_sfx_click : AudioStreamPlayer


func _ready() -> void:
	audio_ambient = AudioStreamPlayer.new()
	add_child(audio_ambient)
	
	audio_sfx = AudioStreamPlayer.new()
	add_child(audio_sfx)
	audio_sfx.bus = "Sfx"
	
	audio_sfx_click = AudioStreamPlayer.new()
	add_child(audio_sfx_click)
	audio_sfx_click.bus = "Sfx"
	#audio_sfx_click.stream = load("res://audio/chapter1/sfx/CLICK_SELECTION_ARROW.wav")


func play_click():
	audio_sfx_click.play()
