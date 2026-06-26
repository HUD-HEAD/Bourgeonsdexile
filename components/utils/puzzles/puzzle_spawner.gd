## Handles extended puzzle obstacle logic : activation, piece spawning, deactivation etc.
class_name PuzzleSpawner
extends Node

## Puzzle to solve
@export var puzzle : DragDropPuzzle

## Spawn a puzzle piece when clicked
@export var spawn_trigger: Clickable
## Obstacle triggering puzzle activation
@export var obstacle : Area2D

func _ready() -> void:
	obstacle.area_entered.connect(_on_obstacle_entered)

	_deactivate_puzzle()
	
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	
func _deactivate_puzzle():
	spawn_trigger.disable()
	puzzle.deactivate()
	puzzle.hide_pieces()
	
	
func _on_obstacle_entered(_area2d : Area2D):
	GameManager.current_puzzle = puzzle
	
	#Signal is one shot
	obstacle.area_entered.disconnect(_on_obstacle_entered)
	
	_activate_spawn_trigger()

func _activate_spawn_trigger():
	#Might trigger multiple times
	if !spawn_trigger.clicked.is_connected(_on_spawner_clicked):
		spawn_trigger.clicked.connect(_on_spawner_clicked)
	spawn_trigger.enable()

## On click, hide trigger and spawn puzzle pieces
func _on_spawner_clicked():
	if spawn_trigger.clicked.has_connections() :
		#Signal is one shot
		spawn_trigger.clicked.disconnect(_on_spawner_clicked)
	spawn_trigger.disable()
	puzzle.spawn_puzzle()

func _on_puzzle_complete():
	obstacle.process_mode = Node.PROCESS_MODE_DISABLED
	_deactivate_puzzle()
