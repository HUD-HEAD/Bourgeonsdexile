extends Area2D

@export var contraction_controller : ContractionController

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _on_area_entered(_area : Area2D):
	contraction_controller.trigger_contraction()

func _on_area_exited(_area : Area2D):
	contraction_controller.stop_contraction()
