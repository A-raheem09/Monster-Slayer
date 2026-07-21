extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuMusic.play(Stats.musicpos)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Stats.musicpos = $MenuMusic.get_playback_position()
	Stats.load_scene('idle')
	pass # Replace with function body.
