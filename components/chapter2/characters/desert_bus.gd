extends Vehicle

@export var desert_controller: DesertController 
var was_last_puzzle_desert: bool = false

var last_desert_area: DesertArea

@export var delay_on_stop:float = 1

@export_group("Audio Config")
@export var moving_loop: TriggerLoopZone
@export var stop_loop: TriggerLoopZone
@export var people_loop: TriggerLoopZone
@export var stop_stream: AudioStream
@export var linear_volume: float = 1
@export var min_pitch: float = 1
@export var max_pitch: float = 1

func _ready() -> void:
	moving_loop.play_loop()
	super._ready()

func _on_area_entered(area : Area2D):
	if area is DesertArea:
		was_last_puzzle_desert = true
		last_desert_area = (area as DesertArea)
	
	_stop_walking()
	InputManager.show_mouse()

func _start_walking():
	if was_last_puzzle_desert:
		desert_controller.on_bus_start()
		last_desert_area.on_finish_puzzle()
	
	if !(was_last_puzzle_desert && last_desert_area.type == DesertArea.puzzle_type.hole_area):
		walking = true
		visuals.process_mode = Node.PROCESS_MODE_INHERIT
		people_loop.stop_loop()
	
	if !was_last_puzzle_desert:
		#if we change the order the fade out stops the new loop
		moving_loop.play_loop()
		stop_loop.stop_loop()
	
	was_last_puzzle_desert = false

func _stop_walking():
	if was_last_puzzle_desert:
		people_loop.play_loop()
		
		if last_desert_area.type == DesertArea.puzzle_type.normal:
			walking = false
			desert_controller.on_bus_stop(move_speed)
		elif last_desert_area.type == DesertArea.puzzle_type.hole_area:
			visuals.process_mode = Node.PROCESS_MODE_DISABLED
			AudioManager.play_audio_stream(stop_stream, linear_volume, min_pitch, max_pitch)
			stop_loop.play_loop()
			moving_loop.stop_loop()
			_stop_after_delay()
	else:
		walking = false
		#HACK stop wheels + vert sine
		visuals.process_mode = Node.PROCESS_MODE_DISABLED
		AudioManager.play_audio_stream(stop_stream, linear_volume, min_pitch, max_pitch)
		stop_loop.play_loop()
		moving_loop.stop_loop()


func _stop_after_delay():
	await get_tree().create_timer(delay_on_stop).timeout
	walking = false
