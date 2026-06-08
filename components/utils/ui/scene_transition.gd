class_name SceneTransition
extends Node

@export var fade_in_curve: Tween.EaseType
@export var fade_out_curve: Tween.EaseType

@export var fade_in_time: float 
@export var fade_out_time: float
@export var waiting_time: float

@export var background: TextureRect

var next_scene: String

enum transition_type{
	scene = 0,
	chapter_1 = 1,
	chapter_2 = 2,
	chapter_3 = 3,
}

@export var scene_transition_type: transition_type = transition_type.scene

func  _ready() -> void:
	if scene_transition_type == transition_type.scene:
		scene_transition()
	elif scene_transition_type == transition_type.chapter_2:
		chapter_2_transition()
	else:
		menu_transition()

func scene_transition():
	var lambda_load_next_scene = func():
		SceneManager.goto_scene(next_scene)
		
	var lambda_destroy_transition = func():
		queue_free()
	
	_trigger_scene_transition(lambda_load_next_scene, Callable(), lambda_destroy_transition)

func menu_transition():
	var lambda_load_menu = func():
		SceneManager.goto_scene(ProjectSettings.get_setting("application/run/main_scene"))
	
	var reset_audio = func():
		AudioManager.reset_audio()
	
	var lambda_destroy_transition = func():
		queue_free()
	
	_trigger_scene_transition(lambda_load_menu, reset_audio, lambda_destroy_transition)

func chapter_2_transition():
	var lambda_load_menu = func():
		AudioManager.reset_audio()
		SceneManager.goto_scene(ProjectSettings.get_setting("application/run/main_scene"))
	
	var lambda_destroy_transition = func():
		queue_free()
	
	_trigger_scene_transition(Callable(), lambda_load_menu, lambda_destroy_transition)

func _trigger_scene_transition(on_finish_fade_in: Callable = Callable(), on_finish_waiting: Callable = Callable(), on_finish_fade_out: Callable = Callable()):
	background.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(background, "modulate:a", 1.0, fade_in_time)
	tween.set_ease(fade_in_curve)
	await get_tree().create_timer(fade_in_time).timeout
	
	if !on_finish_fade_in.is_null():
		on_finish_fade_in.call()
	await get_tree().create_timer(waiting_time).timeout
	
	if !on_finish_waiting.is_null():
		on_finish_waiting.call()
	
	var tween_fade_out = create_tween()
	tween_fade_out.tween_property(background, "modulate:a", 0.0, fade_out_time)
	tween_fade_out.set_ease(fade_out_curve)
	await get_tree().create_timer(fade_out_time).timeout
	
	if !on_finish_fade_out.is_null():
		on_finish_fade_out.call()
