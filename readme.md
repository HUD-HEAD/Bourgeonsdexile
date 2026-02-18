Important : **always use snake_case** naming convention for folders and files (all lowercase, separate words with _)

Please don't use "frame" in file names or folders, reserve it **only** for files that are frames of animation :)

Structure of the folders in the Godot project (words in brackets should be replaced, \# denotes a number) :

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
					└── anim_[animation_name]_[##]fps
						└── [animation_name]_frame[#].png
		└── levels
			└── [level_name]
				├── environment
					├── background
						└── [background_name].png
					└── items
						└── [item_name].png
				├── npcs
					└── [npc_name]
						└── anim_[animation_name]_[##]fps
							└── [animation_name]_frame[#].png
				└── puzzles
					└── puzzle[#]
						├── empty.png
						├── full.png
						└── piece[#].png
		└── main_characters
			└── [main_character_name]
				└── anim_[animation_name]_[##]fps
					└── [animation_name]_frame[#].png
			└── companions
				└──[companion_name]
					└── anim_[animation_name]_[##]fps
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


Note in particular the structure for animations :
```
└── [something]
	└── anim_[animation_name]_[##]fps
		└── [animation_name]_frame[#].png
```

So for example :
```
└── nina
	└── anim_walking_30fps
		├── walking_frame0.png
		├── walking_frame1.png
		└── walking_frame2.png
```
