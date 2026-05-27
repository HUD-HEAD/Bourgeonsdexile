class_name AudioConfiguration extends Resource

enum sfx_type{
	click = 0,
	puzzle = 1,	
}

enum loop_type{
	example = 0,
}

enum music_type{
	example_music = 0,
}

@export var sfx_configuration: Array[sfx_config]
@export var loop_configuration: Array[loop_config]
@export var music_configuration: Array[music_config]
