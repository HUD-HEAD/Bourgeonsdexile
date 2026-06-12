extends Node2D

@export var anim_player : AnimationPlayer
@export var visuals : Node2D

@export var wait_time : float = 5.0
@export var visible_notifier : VisibleOnScreenNotifier2D

func _ready() -> void:
	visuals.hide()
	visible_notifier.screen_entered.connect(_start_timer)
	
func _start_timer():
	get_tree().create_timer(wait_time).timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	anim_player.play("hint")
	visuals.show()


##On interaction, hide tutorial
##And restart timer in case user doesn't fully complete interaction
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("select_element"):
		visuals.hide()
		anim_player.stop()
		_start_timer()
