class_name IdleScreen
extends CanvasLayer

@export var timer : Timer
@export var progress_bar : TextureProgressBar
@export var interact_hint : Node2D

const HINT_SCALING = 1.2
const HINT_DURATION = 2.0

func _ready() -> void:
	progress_bar.max_value = timer.wait_time
	progress_bar.step = timer.wait_time/1000
	timer.timeout.connect(_on_timer_timeout)
	#timer.start()
	
	animate_hint()
	
	stop_process()
	
	
	
func _process(_delta: float) -> void:
	progress_bar.value = timer.time_left

func _on_timer_timeout():
	print_debug("idle screen timeout")
	stop_process()
	SceneManager.goto_scene(ProjectSettings.get_setting("application/run/main_scene"))


func animate_hint():
	var tween = interact_hint.create_tween()
	tween.tween_property(interact_hint, "scale", interact_hint.scale*HINT_SCALING, HINT_DURATION)
	tween.tween_property(interact_hint, "scale", interact_hint.scale/HINT_SCALING, HINT_DURATION)
	tween.set_loops()

func _unhandled_input(event: InputEvent) -> void:
	##Prevent mouse capture being detected as input
	if event is InputEventMouseMotion && event.velocity.is_equal_approx(Vector2.ZERO):
		return
	stop_process()
	print_debug("input")
	IdleManager.start_timer()

func stop_process():
	set_process_unhandled_input(false)
	set_process(false)
	hide()
	timer.stop()
	
	
func start_process():
	timer.start()
	show()
	set_process(true)
	set_process_unhandled_input(true)
	
