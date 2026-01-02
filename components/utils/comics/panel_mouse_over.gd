## Tracks mouse position within an area, and interpolates the corresponding animation frame
extends Area2D

##Collision shape within which mouse position is tracked
@export var collision_shape : CollisionShape2D
##Sprite to update with tracked movement
@export var animated_sprite : AnimatedSprite2D
##Delay between solve and transition (in seconds)
@export var transition_delay : float = 3.0

var tracking : bool = false

#Area within which mouse position is tracked
var tracking_area : Rect2
#Number of frames in the animation
var frame_count : int

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	tracking_area = collision_shape.shape.get_rect()
	frame_count = animated_sprite.sprite_frames.get_frame_count("default")


func _compute_state():
	if !tracking:
		return
	#Local mouse x coordinate within the area
	var loc_mouse = get_local_mouse_position().x - (tracking_area.position.x + collision_shape.position.x)
	
	#Cursor progress through detection area
	var progress =  loc_mouse / tracking_area.size.x
	#Rounded to nearest 10 percent
	progress = snappedf(progress, 0.1)
	
	#Update sprite
	var new_frame = lerp(0, frame_count-1, progress)
	#Prevent skipping frames
	#if new_frame == animated_sprite.frame+1:
	
	animated_sprite.frame = new_frame
	#print_debug(progress)
	
	#Reached end of animation
	if animated_sprite.frame == frame_count-1:
		InputManager.hide_mouse()
		_transition_next_panel()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_velocity = event.screen_velocity
		if mouse_velocity.x > 0: 
			_compute_state()

func _transition_next_panel():
	#Prevent from going backwards in animation
	self.process_mode = Node.PROCESS_MODE_DISABLED
	#Delay transition
	await get_tree().create_timer(transition_delay).timeout
	SignalManager.next_panel.emit()

func _on_mouse_entered():
	tracking = true

func _on_mouse_exited():
	tracking = false
