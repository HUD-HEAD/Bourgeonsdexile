class_name BodaBodaVisualController
extends Node2D

@export var char_area : Area2D
@export var smoke_particles :GPUParticles2D 

@export_group("Audio")
@export var running_loop: TriggerLoopZone
@export var not_running_loop: TriggerLoopZone
@export var brake_sfx: TriggerSfxOnClick

var _initialized: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char_area.area_entered.connect(on_stop_bodaboda)
	smoke_particles.emitting = false

func on_stop_bodaboda(area : Area2D):
	if area is DesertArea:
		var desert_area = (area as DesertArea)
		if desert_area.type == DesertArea.puzzle_type.bodaboda_broke:
			_show_boda_broke()

func on_continue_bodaboda():
	if _initialized:
		smoke_particles.emitting = false
		running_loop.play_loop()
		not_running_loop.stop_loop()


func _show_boda_broke():
	_initialized = true
	
	smoke_particles.emitting = true
	brake_sfx.play_sfx()
	not_running_loop.play_loop()
	running_loop.stop_loop()
