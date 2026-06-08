extends Node2D

@export var rains : Array[GPUParticles2D]
@export var rain_sfx: TriggerLoopZone
@export var obstacle : Area2D

func _ready() -> void:
	obstacle.area_entered.connect(_fade_out_rain.unbind(1))


func _fade_out_rain():
	for rain in rains:
		var tween : Tween = rain.create_tween()
		tween.tween_property(rain, "amount_ratio", 0.0, 5)
		tween.tween_callback(_on_tween_finished.bind(rain))


func _on_tween_finished(rain : GPUParticles2D):
	rain.emitting = false
	await get_tree().create_timer(2).timeout
	SignalManager.obstacle_cleared.emit()
	rain_sfx.trigger_loop()
