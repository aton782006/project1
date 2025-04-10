extends Node

@onready var audio_player = $AudioStreamPlayer  # Reference to the audio player

# List of death sounds
var audio_files = [
	preload("res://lose voiceovers/Nested Sequence 11 (1).mp3"),
	preload("res://lose voiceovers/Nested Sequence 12.mp3"),
	preload("res://lose voiceovers/Nested Sequence 13.mp3"),
	preload("res://lose voiceovers/Nested Sequence 14.mp3"),
	preload("res://lose voiceovers/Nested Sequence 15.mp3"),
	preload("res://lose voiceovers/Nested Sequence 16.mp3"),
	preload("res://lose voiceovers/Nested Sequence 19.mp3"),
	preload("res://lose voiceovers/Nested Sequence 17.mp3")
]

# Function to play a random sound
func play_random_audio():
	if audio_files.size() > 0:
		var random_audio = audio_files[randi() % audio_files.size()]  # Pick a random file
		audio_player.stream = random_audio
		audio_player.play()  # Play sound
