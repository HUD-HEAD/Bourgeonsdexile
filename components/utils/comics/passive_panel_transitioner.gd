##Used on "passive" comic panels to trigger transition when animation is finished, or at the end of timer
extends Node

##Transition will trigger when animation ends
@export var anim_player : AnimationPlayer
##If no animation player is given, will wait this long before triggering transition
@export var timer_wait : float = 5.0

func _ready() -> void:
	#Trigger at end of animation if present
	if anim_player != null :
		anim_player.animation_finished.connect(SignalManager.next_panel.emit.unbind(1))
	#Otherwise create a timer and wait for timeout
	else :
		var timer : Timer = Timer.new()
		timer.wait_time = timer_wait
		timer.one_shot = true
		timer.timeout.connect(SignalManager.next_panel.emit)
		add_child(timer)
		timer.start()
