extends Node

@export var puzzle : DragDropPuzzle

@export var piece_spawners: Array[Node2D]
@export var spawn_trigger: Clickable
@export var obstacle : Area2D


var piece_idx : int = 0

func _ready() -> void:
	assert(piece_spawners.size()>0)

	spawn_trigger.clicked.connect(_on_spawner_clicked)
	obstacle.area_entered.connect(_on_obstacle_entered)

	_deactivate_puzzle()
	
func _deactivate_puzzle():
	spawn_trigger.process_mode = Node.PROCESS_MODE_DISABLED
	puzzle.outline_image.hide()
	
	for piece in puzzle.puzzle_pieces:
		piece.deactivate()
	
	
func _on_obstacle_entered(area2d : Area2D):
	_activate_puzzle()

func _activate_puzzle():
	puzzle.outline_image.show()
	spawn_trigger.process_mode = Node.PROCESS_MODE_INHERIT
	

func _on_spawner_clicked():
	spawn_trigger.hide()
		
	var timer: SceneTreeTimer = get_tree().create_timer(1.0)
	timer.timeout.connect(_npc_bubble)
	
	activate_piece(piece_idx)
	

func activate_piece(idx):
	if idx >= puzzle.puzzle_pieces.size():
		return
	
	var piece : PuzzlePiece = puzzle.puzzle_pieces.keys()[idx]
	
	piece.activate_piece(piece_spawners[idx%piece_spawners.size()].global_position)
	
	increment_idx()


func increment_idx():
	piece_idx += 1
	if piece_idx >= puzzle.puzzle_pieces.size():
		spawn_trigger.clicked.disconnect(_on_spawner_clicked)
		spawn_trigger.hide()


func _npc_bubble():
	activate_piece(piece_idx)
	if piece_idx < puzzle.puzzle_pieces.size():
		spawn_trigger.show()
