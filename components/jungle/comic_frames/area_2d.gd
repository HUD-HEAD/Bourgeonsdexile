## Tracks mouse position within an area, and interpolates the corresponding animation frame
extends Area2D

#Collision shape within which mouse position is tracked
@export var collision_shape : CollisionShape2D
#Sprite to update with tracked movement
@export var animated_sprite : AnimatedSprite2D

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
	


func _process(delta: float) -> void:
	if tracking:
		#Local mouse x coordinate within the area
		var loc_mouse = get_local_mouse_position().x - tracking_area.position.x
		var progress =  loc_mouse / tracking_area.size.x
		
		#Update sprite
		animated_sprite.frame = int(progress * frame_count)
		#print_debug(progress)
		
		

func _on_mouse_entered():
	tracking = true

func _on_mouse_exited():
	tracking = false
	
