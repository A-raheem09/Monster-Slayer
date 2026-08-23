extends Control
func _ready():
	$AnimationPlayer.play("RESET")
	$ColorRect2.visible = false
	if Save.pkeys['newsave'] == true:
		Stats.load_scene('intro')
	if Stats.fade_in == true:
		$AnimationPlayer.play('fade_in')
		Stats.fade_in = false
	Save._save()
	$MenuMusic.play(Stats.musicpos)
	if Save.stats['volume'] == -10:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_volume_db(0,(Save.stats['volume']))
	Stats.damage = Save.stats['damage'] * Save.stats['dmg_mult']
func _process(_delta: float) -> void:
	pass
func _on_inventory_pressed() -> void:
	Stats.musicpos = $MenuMusic.get_playback_position()
	Stats.load_scene('enc')
	#get_tree().change_scene_to_file("res://inventory.tscn") # goes to inventory
func _on_start_pressed() -> void:
	Stats.musicpos = 0
	$AnimationPlayer.play('enter_portal')
	$Timer.start(1.2)
	$Start.disabled = true
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
	var start = func start_game():
			Stats.load_scene('main')
	$AnimationPlayer.play("fade_to_black")
	var timer = get_tree().create_timer(0.5)
	timer.timeout.connect(start)
	

	pass # Replace with function body.
