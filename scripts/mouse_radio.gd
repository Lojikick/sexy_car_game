extends Node
@onready var song_big: AudioStreamPlayer = $song_big
@onready var song_small: AudioStreamPlayer = $song_small

func play_big_song():
	song_big.volume_db = -7
	song_small.volume_db = -80
	
func play_small_song():
	song_big.volume_db = -80
	song_small.volume_db = -7
