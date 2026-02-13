## Handles extended puzzle obstacle logic : activation, piece spawning, deactivation etc.
extends Node

## Puzzle to solve
@export var puzzle : DragDropPuzzle

## The puzzle pieces will be spawned at given spawner nodes positions. Cycles through spawners.
@export var piece_spawners: Array[Node2D]
## Spawn a puzzle piece when clicked
@export var spawn_trigger: Clickable
## Obstacle triggering puzzle activation
@export var obstacle : Area2D

##Index of current piece to be activated
var piece_idx : int = 0


func _ready() -> void:
	assert(piece_spawners.size()>0)
	
	obstacle.area_entered.connect(_on_obstacle_entered)

	_deactivate_puzzle()
	
func _deactivate_puzzle():
	spawn_trigger.disable()
	puzzle.outline_image.hide()
	
	for piece in puzzle.puzzle_pieces:
		piece.deactivate()
	
	
func _on_obstacle_entered(area2d : Area2D):
	#Might trigger multiple times
	if !spawn_trigger.clicked.is_connected(_on_spawner_clicked):
		spawn_trigger.clicked.connect(_on_spawner_clicked)
	spawn_trigger.enable()

## On click, hide trigger and spawn puzzle pieces
func _on_spawner_clicked():
	spawn_trigger.disable()
	
	if piece_idx == 0:
		puzzle.outline_image.show()
	
	#Spawn woman bubble
	_activate_next_piece()
	
	#Spawn NPC bubble after delay
	var timer: SceneTreeTimer = get_tree().create_timer(1.0)
	timer.timeout.connect(_npc_bubble)
	
## Activate given puzzle piece then increment index
func _activate_next_piece():
	if piece_idx >= puzzle.puzzle_pieces.size():
		return
	
	var piece : PuzzlePiece = puzzle.puzzle_pieces[piece_idx]
	piece.activate_piece(piece_spawners[piece_idx%piece_spawners.size()].global_position)
	
	_increment_idx()

## Increment index of puzzle piece
func _increment_idx():
	piece_idx += 1
	if piece_idx >= puzzle.puzzle_pieces.size():
		spawn_trigger.clicked.disconnect(_on_spawner_clicked)
		spawn_trigger.disable()

## Activate NPC bubble and re-enable spawn trigger
func _npc_bubble():
	_activate_next_piece()
	if piece_idx < puzzle.puzzle_pieces.size():
		spawn_trigger.enable()
	
	
