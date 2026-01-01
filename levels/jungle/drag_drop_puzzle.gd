extends Node2D

@export var puzzle_pieces : Dictionary[Draggable, Area2D]
@export var complete_image : Sprite2D

@export var piece_spawners: Array[Node2D]

@export var spawn_trigger: Clickable

@export var obstacle : Area2D

var piece_idx : int = 0

func _ready() -> void:
	assert(piece_spawners.size()>0)
	
	# Associate each draggable piece with its receptacle
	for piece in puzzle_pieces:
		piece.receptacle = puzzle_pieces[piece]
		piece.piece_correctly_placed.connect(_on_correct_piece)
		
		piece.hide()
		piece.process_mode = Node.PROCESS_MODE_DISABLED
		
	spawn_trigger.clicked.connect(_on_spawner_clicked)
	
	obstacle.area_entered.connect(_on_obstacle_entered)
	spawn_trigger.process_mode = Node.PROCESS_MODE_DISABLED

func _on_obstacle_entered(area2d : Area2D):
	spawn_trigger.process_mode = Node.PROCESS_MODE_INHERIT

## Called every time a puzzle piece is correctly placed
func _on_correct_piece():
	if _check_complete():
		_complete_puzzle()

## When puzzle is complete, disable interaction
func _complete_puzzle():
	print_debug("puzzle complete")
	process_mode = Node.PROCESS_MODE_DISABLED
	complete_image.show()
	SignalManager.obstacle_cleared.emit()
	

## Check if all puzzles are in the correct place
func _check_complete() -> bool:
	for piece in puzzle_pieces:
		if !piece.is_correctly_placed():
			return false
	
	return true


func _on_spawner_clicked():
	spawn_trigger.hide()
		
	var timer: SceneTreeTimer = get_tree().create_timer(1.0)
	timer.timeout.connect(_npc_bubble)
	
	activate_piece(piece_idx)
	

func activate_piece(idx):
	var piece : Draggable = puzzle_pieces.keys()[idx]
	piece.global_position = piece_spawners[idx%piece_spawners.size()].global_position
	piece.process_mode = Node.PROCESS_MODE_INHERIT
	piece.show()
	
	increment_idx()


func increment_idx():
	piece_idx += 1
	if piece_idx >= puzzle_pieces.size():
		spawn_trigger.clicked.disconnect(_on_spawner_clicked)
		spawn_trigger.hide()


func _npc_bubble():
	activate_piece(piece_idx)
	if piece_idx < puzzle_pieces.size():
		spawn_trigger.show()
