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



#region Fade in/out, crossfade
const TRANS_TIME = 5.0

func cross_fade(fade_out_player : AudioStreamPlayer, fade_in_player : AudioStreamPlayer):
	fade_out(fade_out_player)
	fade_in(fade_in_player)

func fade_out(fade_out_player : AudioStreamPlayer):
	if !is_instance_valid(fade_out_player):
		return
	
	var tween : Tween = fade_out_player.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(fade_out_player, "volume_linear", 0.0, TRANS_TIME)
	tween.tween_callback(fade_out_player.stop)

func fade_in(fade_in_player : AudioStreamPlayer):
	if !is_instance_valid(fade_in_player):
		return
		
	fade_in_player.volume_linear = 0.0
	fade_in_player.play()
	
	var tween : Tween = fade_in_player.create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_in_player, "volume_linear", 1.0, TRANS_TIME)
#endregion
