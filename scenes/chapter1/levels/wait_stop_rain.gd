extends Node2D

@export var puzzle : DragDropPuzzle
@export var rains : Array[GPUParticles2D]
@export var nina : Woman
@export var rain_sfx: TriggerLoopZone

func _ready() -> void:
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	
func _on_puzzle_complete():
	nina._stop_walking()
	for rain in rains:
		var tween : Tween = rain.create_tween()
		tween.tween_property(rain, "amount_ratio", 0.0, 5)
		tween.tween_callback(_on_tween_finished.bind(rain))



func _on_tween_finished(rain : GPUParticles2D):
	rain.emitting = false
	await get_tree().create_timer(2).timeout
	SignalManager.obstacle_cleared.emit()
	rain_sfx.trigger_loop()
