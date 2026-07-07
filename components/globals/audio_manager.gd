
extends Node

## Used for sounds that need to persist through scene transitions
var audio_ambient : AudioStreamPlayer
var audio_sfx : AudioStreamPlayer
## Assign Stream for consistent click sound throughout game
var audio_sfx_click : AudioStreamPlayer

# ── Audio Stream Players ────────────────────────────────────────
var sfx_player : AudioStreamPlayer
var polyphonic_stream: AudioStreamPolyphonic 
var polyphonic_player: AudioStreamPlaybackPolyphonic

var music_1_player : AudioStreamPlayer
var music_2_player : AudioStreamPlayer

var loop_players_pool: Array[AudioStreamPlayer]

# ── Data ────────────────────────────────────────
var audio_config: AudioConfiguration

var sfx_dictionary: Dictionary[AudioConfiguration.sfx_type, sfx_config] = {}
var loop_dictionary: Dictionary[AudioConfiguration.loop_type, loop_config] = {}
var music_dictionary: Dictionary[AudioConfiguration.music_type, music_config] = {}

var loop_pool: Array[loop_pool_item]
# ── Variables ────────────────────────────────────────
var last_music_player: int = -1
var last_music_playing: AudioConfiguration.music_type = AudioConfiguration.music_type.c2_1_starting_theme
var last_walking_loop: AudioConfiguration.loop_type = AudioConfiguration.loop_type.none

var last_sfx_id: int
var tv_loop: AudioStreamPlayer
var tv_index: int 

const LOOP_POOL_SIZE = 6
const TV_VOLUMES: Array[float] = [0.7, 1, 1.3, 1.5]

# ── Structure ────────────────────────────────────────
class loop_pool_item:
	var is_playing: bool
	var loop_type: AudioConfiguration.loop_type = AudioConfiguration.loop_type.none
	var player_reference: AudioStreamPlayer
	
	func _init (player: AudioStreamPlayer):
		is_playing = false
		player_reference = player


func _ready() -> void:
	audio_ambient = AudioStreamPlayer.new()
	add_child(audio_ambient)
	
	audio_sfx = AudioStreamPlayer.new()
	add_child(audio_sfx)
	audio_sfx.bus = "Sfx"
	
	audio_sfx_click = AudioStreamPlayer.new()
	add_child(audio_sfx_click)
	audio_sfx_click.bus = "Sfx"
	#audio_sfx_click.stream = load("res://audio/chapter1/sfx/CLICK_SELECTION_ARROW.wav")
	
	init_dictionaries()


#region Inits
func init_dictionaries():
	audio_config = preload("res://components/utils/audio/audio_configurations/audio_config.tres")
	
	_init_sfx()
	_init_loop()
	_init_music()
	
	_init_players()
	
	

func _init_sfx():
	for sfx in audio_config.sfx_configuration:
		sfx_dictionary[int(sfx.type)] = sfx

func _init_loop():
	for loop in audio_config.loop_configuration:
		loop_dictionary[int(loop.type)] = loop

func _init_music():
	for music in audio_config.music_configuration:
		music_dictionary[int(music.type)] = music

func _init_players():
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	
	sfx_player.bus = "Sfx"
	sfx_player.name = "sfx_player"
	#sfx_player.max_polyphony = 10
	
	polyphonic_stream = AudioStreamPolyphonic.new()
	polyphonic_stream.polyphony = 10
	sfx_player.stream = polyphonic_stream
	sfx_player.play()
	polyphonic_player = sfx_player.get_stream_playback()
	
	
	music_1_player = AudioStreamPlayer.new()
	music_2_player = AudioStreamPlayer.new()
	add_child(music_1_player)
	add_child(music_2_player)
	
	music_1_player.bus = "Music"
	music_2_player.bus = "Music"
	music_1_player.name = "music_player_1"
	music_2_player.name = "music_player_2"
	
	loop_players_pool.resize(LOOP_POOL_SIZE)
	loop_pool.resize(LOOP_POOL_SIZE)
	
	for i in range(LOOP_POOL_SIZE):
		# Create new Audio Stream Player for loops
		var loop_player =  AudioStreamPlayer.new()
		loop_player.bus = "Sfx"
		loop_player.name = "loop_player_" + str(i)
		loop_players_pool[i] = loop_player
		
		# Create a loop_pool_item for the control of the pool
		var loop_item = loop_pool_item.new(loop_player)
		loop_pool[i] = loop_item
		
		add_child(loop_player)
	
#endregion

#region Play
func play_click():
	audio_sfx_click.play()

func play_sfx(key: AudioConfiguration.sfx_type):
	var sfx: sfx_config = _get_sfx(key)
	
	var stream
	var pitch: float
	var volume: float
	
	if sfx.stream.size() > 1:
		stream = sfx.stream[randi_range(0,sfx.stream.size() -1)]
	elif sfx.stream.size() == 1:
		stream = sfx.stream[0]
	else:
		assert("No SFX assigned to key: " + str(key))
	
	if sfx.min_pitch != sfx.max_pitch: 
		pitch = randf_range(sfx.min_pitch, sfx.max_pitch)
	else: 
		pitch = sfx.min_pitch
	
	if sfx.min_volume != sfx.max_volume: 
		volume = randf_range(sfx.min_volume, sfx.max_volume)
	else: 
		volume = sfx.min_volume
	
	polyphonic_player.play_stream(stream, 0, linear_to_db(volume), pitch, 0 as AudioServer.PlaybackType, "Sfx")

func play_audio_stream(stream: AudioStream, volume: float = 1, min_pitch: float = 1, max_pitch: float = 1, save_sfx_id: bool = false):
	var pitch: float = min_pitch
	if min_pitch != max_pitch:
		pitch = randf_range(min_pitch, max_pitch)
	var id = polyphonic_player.play_stream(stream, 0, linear_to_db(volume), pitch, 0 as AudioServer.PlaybackType, "Sfx")
	if save_sfx_id:
		last_sfx_id = id

func stop_last_sfx_saved():
	polyphonic_player.stop_stream(last_sfx_id)

func play_loop(key: AudioConfiguration.loop_type) -> AudioStreamPlayer:
	var loop: AudioStreamPlayer = _get_free_loop(key)
	var loop_info: loop_config = _get_loop(key)
	
	_check_lullaby(key, true)
	
	if loop != null:
		loop.volume_linear = loop_info.volume
		loop.pitch_scale = loop_info.pitch
		loop.stream = loop_info.stream
	
		#loop.play()
		fade_in(loop, 0, loop_info.volume)
	
	return loop
	
func stop_loop(key: AudioConfiguration.loop_type, fade_in_enable: bool = true, fade_out_volume: float = 0):
	_free_loop(key, fade_in_enable, fade_out_volume)
	_check_lullaby(key, false)

func free_walking_loop(key: AudioConfiguration.loop_type, fade_in_enable: bool = true ):
	last_walking_loop = AudioConfiguration.loop_type.none
	stop_loop(key, fade_in_enable)

func play_tv_loop(key: AudioConfiguration.loop_type):
	tv_loop = play_loop(key)
	tv_index = 0

func increase_tv_volume():
	tv_index += 1
	if tv_index < TV_VOLUMES.size():
		tv_loop.volume_linear = TV_VOLUMES[tv_index]

func play_music(key: AudioConfiguration.music_type):
	if last_music_playing == key && last_music_player > -1:
		pass
	else:
		last_music_playing = key
		var music_info: music_config = _get_music(key)
		var has_to_fade_out = true
		var current_music_player: AudioStreamPlayer
	
		if last_music_player == -1:
			current_music_player = music_1_player
			has_to_fade_out = false
			last_music_player = 1
		elif last_music_player == 0:
			current_music_player = music_1_player
			last_music_player = 1
		else:
			current_music_player = music_2_player
			last_music_player = 0
	
		current_music_player.pitch_scale = music_info.pitch
		current_music_player.stream = music_info.stream
	#(current_music_player.stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD
	
		fade_in(current_music_player, 0, music_info.volume)
		if has_to_fade_out:
			if last_music_player == 0:
				fade_out(music_1_player)
			else:
				fade_out(music_2_player)

func stop_music():
	fade_out(music_1_player)
	fade_out(music_2_player)
	
	#reset last music player index
	last_music_player = -1

func play_walking_loop():
	if last_walking_loop != -1:
		play_loop(last_walking_loop)

func stop_walking_loop():
	stop_loop(last_walking_loop, false)



#endregion

#region Utils
func update_last_walking_loop(key: AudioConfiguration.loop_type):
	stop_walking_loop()
	last_walking_loop = key
	play_walking_loop()

func reset_audio():
	_stop_loops()
	_stop_sfx()
	stop_music()

func _get_sfx(key: AudioConfiguration.sfx_type) -> sfx_config:
	if sfx_dictionary[key]:
		return sfx_dictionary[key]
	
	assert("Key: " + str(key) + " is not setted on audio_config")
	return null

func _get_loop(key: AudioConfiguration.loop_type) -> loop_config:
	if loop_dictionary[key]:
		return loop_dictionary[key]
	
	assert("Key: " + str(key) + " is not setted on audio_config")
	return null
	
func _get_music(key: AudioConfiguration.music_type) -> music_config :
	if music_dictionary[key]:
		return music_dictionary[key]
	
	assert("Key: " + str(key) + " is not setted on audio_config")
	return null

func _get_free_loop(key: AudioConfiguration.loop_type) -> AudioStreamPlayer:
	for item in loop_pool:
		if item.loop_type == key && item.is_playing:
			return null
		elif !item.is_playing:
			item.loop_type = key
			item.is_playing = true
			return item.player_reference
	
	assert("No free loops available in the pool.")
	return null

func _free_loop(key: AudioConfiguration.loop_type, fade_in_enable: bool = true, fade_out_volume: float = 0):
	for item in loop_pool:
		if item.is_playing && item.loop_type == key:
			if fade_in_enable:
				var lambda = func():
					item.is_playing = false
					item.player_reference.stop()
				fade_out(item.player_reference, fade_out_volume, lambda)
			else:
				item.is_playing = false
				item.player_reference.stop()
			break

func _stop_loops():
	for item in loop_pool:
		item.is_playing = false
		item.player_reference.stop()

func _stop_sfx():
	polyphonic_player.stop()
	polyphonic_player.start()

func _stop_all_sfx():
	sfx_player.stop()
	sfx_player.play()
	polyphonic_player = sfx_player.get_stream_playback()

#endregion

#region Fade in/out, crossfade
const TRANS_TIME = 1

func cross_fade(fade_out_player : AudioStreamPlayer, fade_in_player : AudioStreamPlayer, min_volume = 0.0, max_volume = 1.0):
	fade_out(fade_out_player, min_volume)
	fade_in(fade_in_player, min_volume, max_volume)

func fade_out(fade_out_player : AudioStreamPlayer, end_volume = 0.0, on_stop: Callable = Callable()):
	if !is_instance_valid(fade_out_player):
		return
	
	var tween : Tween = fade_out_player.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(fade_out_player, "volume_linear", end_volume, TRANS_TIME)
	tween.tween_callback(fade_out_player.stop)
	if on_stop.is_valid():
		on_stop.call()

func fade_in(fade_in_player : AudioStreamPlayer, start_volume = 0.0, end_volume = 1.0):
	if !is_instance_valid(fade_in_player):
		return
		
	fade_in_player.volume_linear = start_volume
	fade_in_player.play()
	
	var tween : Tween = fade_in_player.create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_in_player, "volume_linear", end_volume, TRANS_TIME)
#endregion

#region lullaby
func _check_lullaby(key: AudioConfiguration.loop_type, is_playing: bool):
	if key == AudioConfiguration.loop_type.c3_l_nana:
		if is_playing:
			decrease_music_volume()
		else:
			increase_music_volume()

const reduced_music_volume:float = 0.5

func decrease_music_volume():
	var current_music_player: AudioStreamPlayer = get_current_music_player()
	
	var tween : Tween = current_music_player.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(current_music_player, "volume_linear", reduced_music_volume, TRANS_TIME)

func increase_music_volume():
	var current_music_player: AudioStreamPlayer = get_current_music_player()
	
	var tween : Tween = current_music_player.create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(current_music_player, "volume_linear", 1, TRANS_TIME)

func get_current_music_player() -> AudioStreamPlayer:
		var current_music_player: AudioStreamPlayer
		
		if last_music_player <= 0:
			current_music_player = music_2_player
		else:
			current_music_player = music_1_player
		
		return current_music_player

#endregion
