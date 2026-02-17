Important : always use snake_case naming convention for folders and files (all lowercase, separate words with _)



Structure of the folders in the Godot project (words in brackets should be replaced, \# denotes a number)

```
├── audio
	└── chapter[#]
		├── music
		└── sfx
├── components
├── graphics
	├── chapter[#]
		└── comics
			└──  comic[#]
				└──  panel_[name]
					├── [name].png
					└── [animation_name]
						└── [animation_name]_frame[#].png
		└── levels
			└── [level_name]
				├── environment
					├── background
					└── items
						└── [object_name].png
				├── puzzles
					└── puzzle[#]
						├── empty.png
						├── full.png
						└── bubble[#].png
				└── npcs
					└── [npc_name]
						└── [animation_name]
							└── [animation_name]_frame[#].png
		└── main_characters
			└── [main_character_name]
				└── [animation_name]
					└── [animation_name]_frame[#].png
			└── companions
				└──[companion_name]
					└── [animation_name]
						└── [animation_name]_frame[#].png
	├── menus
		├── main_menu
		├── pause_menu
		└── credits
	└── ui
		├── buttons
		└── cursor
├── scenes
└── video
```
