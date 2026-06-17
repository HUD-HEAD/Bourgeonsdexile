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
	puzzle.outline_image.hide()
	
	for piece in puzzle.puzzle_pieces:
		piece.deactivate()
		piece.draggable.hide()
	
	
func _on_obstacle_entered(area2d : Area2D):
	GameManager.current_puzzle_spawner = self
	
	#Signal is one shot
	obstacle.area_entered.disconnect(_on_obstacle_entered)
	
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
	piece.spawn_piece(piece.global_position)


func _on_puzzle_complete():
	obstacle.process_mode = Node.PROCESS_MODE_DISABLED
	_deactivate_puzzle()

## Debug function
func autosolve_puzzle():
	#Spawn all pieces
	var pieces_amount =  puzzle.puzzle_pieces.size()
	for idx in pieces_amount:
		_spawn_piece(idx)
	
	#Show outline
	puzzle.outline_image.show()
	
	#Enable interactivity
	for piece in puzzle.puzzle_pieces:
		piece.enable_piece()
		##HACK x2 :
		## Can fail if two puzzle pieces have the same primary recptacle
		## Simulates placement checker being validated
		piece.placement_checker.current_receptacle = piece.placement_checker.receptacles[0]
		piece.placement_checker.current_receptacle.occupied = true
		
		piece._snap_to_receptacle()
	
	#HACK : need to delay so _snap is finished and puzzle area overlap is updated by the time we check
	get_tree().create_timer(0.8).timeout.connect(puzzle._on_correct_piece)
