extends Node

var timer : Timer
var idle_screen : IdleScreen = preload("res://components/utils/ui/idle_screen.tscn").instantiate()
##In seconds, before idle screen appears
const IDLE_TIME : float = 180

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = IDLE_TIME
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	add_child(idle_screen)
	
func _on_timer_timeout():
	print_debug("idle timeout")
	idle_screen.start_process()

func stop_timer():
	print_debug("stopped idle timer")
	timer.stop()

func start_timer():
	print_debug("started idle timer")
	timer.start()

func _input(event: InputEvent) -> void:
	##If timer is running, reset it
	if !timer.is_stopped():		#(prevents e.g. input in menu wrongly starting timer)
		timer.start()
