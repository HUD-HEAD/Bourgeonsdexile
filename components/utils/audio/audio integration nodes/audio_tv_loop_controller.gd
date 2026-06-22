class_name TvLoopController
extends VisibleOnScreenNotifier2D

@export var loop_name: AudioConfiguration.loop_type
@export var start_loop_on_enter_screen: bool = true
@export var clickables : Array[Clickable]


func _ready() -> void:
	if start_loop_on_enter_screen:
		self.screen_entered.connect(trigger_loop)
	
	for clickable in clickables:
		clickable.clicked.connect(increase_volume)

func trigger_loop():
	AudioManager.play_tv_loop(loop_name)

func increase_volume():
	AudioManager.increase_tv_volume()

func stop_loop():
	AudioManager.stop_loop(loop_name)
