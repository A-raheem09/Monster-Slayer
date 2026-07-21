extends Control
func _ready():
	print(Save.skills[0])
	Save._save()
	$MenuMusic.play(Stats.musicpos)
	if Save.stats['volume'] == -10:
		AudioServer.set_bus_mute(0,true)
	Stats.damage = Save.stats['damage'] * Save.stats['dmg_mult']
func _process(_delta: float) -> void:
	if not $Timer.is_stopped():
		$CanvasLayer/Start/Wait.text = str(int($Timer.time_left)) + 's..'
func _on_inventory_pressed() -> void:
	$Label.text = "Still Under Construction"
	#get_tree().change_scene_to_file("res://inventory.tscn") # goes to inventory
func _on_start_pressed() -> void:
	Stats.musicpos = 0
	$Timer.start(6.7)
	$CanvasLayer/Start.disabled = true
func _on_save_pressed() -> void:
	Save._save()
	pass
func _on_options_pressed() -> void:
	Stats.musicpos = $MenuMusic.get_playback_position()
	Stats.load_scene('options')
	pass # Replace with function body.
func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
func _on_skills_pressed() -> void:
	Stats.musicpos = $MenuMusic.get_playback_position()
	Stats.load_scene('skills')
	pass # Replace with function body.
func _on_timer_timeout() -> void:
	Stats.load_scene('main')
	pass # Replace with function body.
