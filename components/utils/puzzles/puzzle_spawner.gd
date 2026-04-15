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

func _ready() -> void:
	assert(piece_spawners.size()>0)
	
	obstacle.area_entered.connect(_on_obstacle_entered)

	_deactivate_puzzle()
	
	puzzle.puzzle_complete.connect(_on_puzzle_complete)
	
func _deactivate_puzzle():
	spawn_trigger.disable()
	puzzle.outline_image.hide()
	
	for piece in puzzle.puzzle_pieces:
		piece.deactivate()
		piece.draggable.hide()
	
	
func _on_obstacle_entered(area2d : Area2D):
	#Signal is one shot
	obstacle.area_entered.disconnect(_on_obstacle_entered)
	
	#Might trigger multiple times
	if !spawn_trigger.clicked.is_connected(_on_spawner_clicked):
		spawn_trigger.clicked.connect(_on_spawner_clicked)
	spawn_trigger.enable()

## On click, hide trigger and spawn puzzle pieces
func _on_spawner_clicked():
	#Signal is one shot
	spawn_trigger.clicked.disconnect(_on_spawner_clicked)
	spawn_trigger.disable()
	_spawn_puzzle()

func _spawn_puzzle():
	#Spawn all pieces
	var pieces_amount =  puzzle.puzzle_pieces.size()
	for idx in pieces_amount:
		_spawn_piece(idx)
		#Delay spawn next piece
		await get_tree().create_timer(0.5).timeout
	
	#Show outline
	puzzle.outline_image.show()
	
	#Enable interactivity
	for piece in puzzle.puzzle_pieces:
		piece.enable_piece()

## Activate given puzzle piece. #NOTICE does NOT check if idx is valid
func _spawn_piece(piece_idx : int):
	var piece : PuzzlePiece = puzzle.puzzle_pieces[piece_idx]
	
	if GameManager.puzzle_automatic_positioning :
		var target_pos = _compute_spawn_position(piece_idx)
		piece.spawn_piece(target_pos)
	else :
		piece.spawn_piece(piece.global_position)

func _compute_spawn_position(piece_idx : int):
	var prev_piece_idx = piece_idx-piece_spawners.size()
	var current_piece = puzzle.puzzle_pieces[piece_idx]
	var y_offset = current_piece.get_dimensions().y/2
	
	#No previous piece spawned here
	if prev_piece_idx < 0 :
		return  piece_spawners[piece_idx%piece_spawners.size()].global_position + y_offset*Vector2.UP
	
	
	var prev_piece = puzzle.puzzle_pieces[prev_piece_idx]
	
	#Offset vertically from previous piece
	y_offset += prev_piece.get_dimensions().y/2
	
	return prev_piece.draggable.global_position + y_offset*Vector2.UP


func _on_puzzle_complete():
	obstacle.process_mode = Node.PROCESS_MODE_DISABLED
	_deactivate_puzzle()
