extends Node

@export var puzzle_spawner : PuzzleSpawner

@export var zoom_in : Vector2 = Vector2(2.0,2.0)
var zoom_out : Vector2
var zoom_speed : float = 3.0


var camera_base_position : Vector2
var camera : Camera2D 

func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	camera_base_position = camera.position
	zoom_out = camera.zoom
	
	puzzle_spawner.obstacle.area_entered.connect(_on_obstacle_entered)
	puzzle_spawner.puzzle.puzzle_complete.connect(_on_puzzle_complete)


func _on_obstacle_entered(_area2d : Area2D):
	_zoom_in()

func _on_puzzle_complete():
	_zoom_out()

func _zoom_in():
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom", zoom_in, zoom_speed)
	tween.tween_property(camera, "global_position", puzzle_spawner.puzzle.global_position, zoom_speed)
	
func _zoom_out():
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera, "zoom", zoom_out, zoom_speed)
	tween.tween_property(camera, "position", camera_base_position, zoom_speed)
	
