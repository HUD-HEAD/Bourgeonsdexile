class_name DesertController
extends Node


#Variables
var background_movement_enabled: bool = false
var acumulated_distance: float
var movement_speed: float
@export var background_size: float = 7680
@export var background_reference: TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	acumulated_distance = 0
	background_movement_enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if background_movement_enabled:
		background_movement(delta)


func on_bus_stop(speed: float):
	movement_speed = speed
	start_background_movement()

func on_bus_start():
	stop_background_movement()

func start_background_movement():
	background_movement_enabled = true

func stop_background_movement():
	background_movement_enabled = false
	reset_background()

func background_movement(delta: float):
	var distance = movement_speed * delta
	acumulated_distance += distance
	background_reference.position.x -= distance
	
	if acumulated_distance >= background_size:
		reset_background()

func reset_background():
	background_reference.position.x += background_size
	acumulated_distance -= background_size
