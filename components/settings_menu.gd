class_name SettingsController extends CanvasLayer

@onready var master_slider = $TextureRect/MasterSlider
@onready var music_slider = $TextureRect/MusicSlider
@onready var sfx_slider = $TextureRect/SFXSlider
@onready var cursor_slider = $TextureRect/CursorSlide
@onready var fullscreen_check = $TextureRect/FullscreenCheck
@onready var vsync_check = $TextureRect/VsyncCheck
@onready var close_button = $TextureRect/CloseButton
@onready var credits_button = $TextureRect/CreditsButton
@onready var reset_button = $TextureRect/ResetButton
@onready var reset_progress_button = $TextureRect/ResetProgressButton
@onready var credits_container = $CreditsContainer
@onready var resolution_container = $TextureRect/MenuButton
@onready var resolution_popup: PopupMenu = resolution_container.get_popup()

@onready var resolution_icon: Sprite2D = $TextureRect/MenuButton/ResolutionIcon

@export var resolution_textures: Array[Texture2D]

const CURSOR_MIN = 0.5
const CURSOR_MAX = 2.0
const CURSOR_STEP = 0.05

const resolutions_modes = {
	"360": {"size": Vector2i(640, 360), "scale": 0.334},
	"720": {"size": Vector2i(1280, 720), "scale": 0.667},
	"1080": {"size": Vector2i(1920, 1080), "scale": 1},
	"2": {"size": Vector2i(2560, 1440), "scale": 1.334},
	"4": {"size": Vector2i(3840, 2160), "scale": 2},
}

static  var has_been_initialized = false
static var player_preferences: PlayerPreferences
static var main_viewport: Viewport

func _ready() -> void:
	_initialize(get_viewport())
	_set_initial_values()
	
	#Asign delegates for sliders, buttons & toggle
	master_slider.connect("value_changed", _on_master_slider_value_changed)
	music_slider.connect("value_changed", _on_music_slider_value_changed)
	sfx_slider.connect("value_changed", _on_sfx_slider_value_changed)
	cursor_slider.connect("value_changed", _on_cursor_slide_value_changed)
	fullscreen_check.connect("toggled", _on_fullscreen_check_toggled)
	vsync_check.connect("toggled", _on_vsync_check_toggled)
	reset_button.connect("pressed", _on_reset_player_preferences)
	reset_progress_button.connect("pressed", _on_reset_player_progress)
	close_button.connect("pressed", _on_close_button_pressed)
	credits_button.connect("pressed", _on_credits_button_pressed)
	resolution_popup.id_pressed.connect(_on_popup_menu_value_change)

func _set_initial_values():
	# Cargar valores guardados
	master_slider.value = player_preferences.master_volume
	music_slider.value = player_preferences.music_volume
	sfx_slider.value = player_preferences.sfx_volume
	cursor_slider.value = player_preferences.cursor_size
	fullscreen_check.button_pressed = player_preferences.is_fullscreen
	vsync_check.button_pressed = player_preferences.is_vsync
	resolution_icon.set_texture(resolution_textures[_get_resolution_texture_index(player_preferences.resolution)])
	
	# Configurar rango del cursor slider
	cursor_slider.min_value = CURSOR_MIN
	cursor_slider.max_value = CURSOR_MAX
	cursor_slider.step = CURSOR_STEP

static func _initialize(viewport_aux: Viewport):
	if !has_been_initialized:
		has_been_initialized = true
		#Load Player Preferences
		player_preferences = PlayerPreferences.load_player_preferences()
	
		#Load ViewPort for setting resolution
		main_viewport = viewport_aux
		
		# Apply save values
		_apply_settings()
	

static func _apply_settings():
	_apply_master_volume(player_preferences.master_volume)
	_apply_music_volume(player_preferences.music_volume)
	_apply_sfx_volume(player_preferences.sfx_volume)
	_apply_cursor_size(player_preferences.cursor_size)
	_apply_fullscreen(player_preferences.is_fullscreen)
	_apply_vsync(player_preferences.is_vsync)
	#_apply_resolution_value(player_preferences.resolution)

# ── Sliders ──────────────────────────────────────────
func _on_master_slider_value_changed(value: float) -> void:
	player_preferences.master_volume = value
	_apply_master_volume(value)
	_save_player_preferences()

func _on_music_slider_value_changed(value: float) -> void:
	player_preferences.music_volume = value
	_apply_music_volume(value)
	_save_player_preferences()

func _on_sfx_slider_value_changed(value: float) -> void:
	player_preferences.sfx_volume = value
	_apply_sfx_volume(value)
	_save_player_preferences()

func _on_cursor_slide_value_changed(value: float) -> void:
	player_preferences.cursor_size = value
	_apply_cursor_size(value)
	_save_player_preferences()

# ── Toggles ────────────────────────────────────────
func _on_fullscreen_check_toggled(pressed: bool) -> void:
	player_preferences.is_fullscreen = pressed
	_apply_fullscreen(pressed)
	_save_player_preferences()

func _on_vsync_check_toggled(pressed: bool) -> void:
	player_preferences.is_vsync = pressed
	_apply_vsync(player_preferences.is_vsync)
	_save_player_preferences()

# ── Resolution Dropdown ────────────────────────────────────────
func _on_popup_menu_value_change(id: int) -> void:
	player_preferences.resolution = id
	var resolution_sprite_index = _get_resolution_texture_index(id)
	resolution_icon.set_texture(resolution_textures[resolution_sprite_index])
	match id:
		360:
			_apply_resolution_value("360")
		720:
			_apply_resolution_value("720")
		1080:
			_apply_resolution_value("1080")
		2:
			_apply_resolution_value("2")
		4:
			_apply_resolution_value("4")
	_save_player_preferences()

func _get_resolution_texture_index(id: int) -> int:
	match id:
		360:
			return 0
		720:
			return 1
		1080:
			return 2
		2:
			return 3
		4:
			return 4
	
	return 2


# ── Reset Player Preferences ────────────────────────────────────────
func _on_reset_player_preferences():
	player_preferences = PlayerPreferences.reset_player_preferences()
	_apply_settings()
	_set_initial_values()

func _on_reset_player_progress():
	SaveManager.reset_save_file()

# ── Idiomas ───────────────────────────────────────────
#func _on_button_es_pressed() -> void:
	#GameManager.language = "ES"
#
#func _on_button_en_pressed() -> void:
	#GameManager.language = "EN"
#
#func _on_button_fr_pressed() -> void:
	#GameManager.language = "FR"
#
#func _on_button_it_pressed() -> void:
	#GameManager.language = "IT"
#
#func _on_button_zh_pressed() -> void:
	#GameManager.language = "ZH"
#
#func _on_button_ar_pressed() -> void:
	#GameManager.language = "AR"
#
#func _on_button_jp_pressed() -> void:
	#GameManager.language = "JP"
#
#func _on_button_fa_pressed() -> void:
	#GameManager.language = "FA"

# ── Créditos ──────────────────────────────────────────
func _on_credits_button_pressed() -> void:
	if 	credits_container:
		credits_container.visible = true

# ── Cerrar ────────────────────────────────────────────
func _on_close_button_pressed() -> void:
	if credits_container.visible:
		credits_container.visible = false
	else :	
		SceneManager.close_settings()


# ── Aplicar valores ───────────────────────────────────
static func _apply_master_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

static func _apply_music_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)

static func _apply_sfx_volume(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Sfx"), value)

static func _apply_cursor_size(value: float) -> void:
	CustomCursor.update_cursor_scale(value)

static func _apply_fullscreen(value: bool) -> void:
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		#Get actual screen index
		var screen_index: int = DisplayServer.window_get_current_screen()
		
		#calculate screnn sizes
		var full_size = DisplayServer.screen_get_size(screen_index) 
		var window_size = Vector2i(int(full_size.x * 0.75), int(full_size.y * 0.75))
		
		#Set new size & deactivate borderless
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(window_size)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		
		#center screen on the center
		var new_screen_position = DisplayServer.screen_get_position(screen_index) + (full_size - window_size) / 2
		DisplayServer.window_set_position(new_screen_position, screen_index)

static func _apply_vsync(value: bool) -> void:
	if value:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

static func _apply_resolution_value(key: String) -> void:
	var root_node = Engine.get_main_loop().root
	print(root_node)
	var resolution = resolutions_modes[key]
	var scale_res: float = resolution["scale"]
	main_viewport.content_scale_factor = scale_res
	main_viewport.content_scale_size = resolution["size"]
	#root_node.scale = Vector2(scale, scale)
	
	if !player_preferences.is_fullscreen:
		DisplayServer.window_set_size(resolutions_modes[key]["size"])

 # ── Save Player Preferences ───────────────────────────────────
func _save_player_preferences() -> void:
	player_preferences.save()
