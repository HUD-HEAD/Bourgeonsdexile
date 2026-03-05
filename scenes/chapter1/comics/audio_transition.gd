extends Node

@export var fade_out_player : AudioStreamPlayer
@export var fade_in_player : AudioStreamPlayer
@export var visible_notif : VisibleOnScreenNotifier2D

const TRANS_TIME = 5.0


func _ready() -> void:
	if is_instance_valid(visible_notif):
		visible_notif.screen_entered.connect(cross_fade)

func cross_fade():
	fade_out()
	fade_in()

	
func fade_out():
	if !is_instance_valid(fade_out_player):
		return
	
	var tween : Tween = fade_out_player.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(fade_out_player, "volume_linear", 0.0, TRANS_TIME)
	tween.tween_callback(fade_out_player.stop)

func fade_in():
	if !is_instance_valid(fade_in_player):
		return
		
	fade_in_player.volume_linear = 0.0
	fade_in_player.play()
	
	var tween : Tween = fade_in_player.create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_in_player, "volume_linear", 1.0, TRANS_TIME)
