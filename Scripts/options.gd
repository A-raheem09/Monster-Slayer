extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuMusic.play(Stats.musicpos)
	if Save.stats['volume'] == -10:
		$CanvasLayer/VBoxContainer/NinePatchRect/CheckBox.button_pressed = true
		AudioServer.set_bus_mute(0,true)
		$CanvasLayer/VBoxContainer/NinePatchRect/HSlider.set_value_no_signal(-5)
	else:
		$CanvasLayer/VBoxContainer/NinePatchRect/HSlider.set_value_no_signal(Save.stats['volume'])
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Save.stats['volume'] == -10:
		$CanvasLayer/VBoxContainer/NinePatchRect/CheckBox.button_pressed = true
		$CanvasLayer/VBoxContainer/NinePatchRect/HSlider.set_value_no_signal(-5)
	else:
		$CanvasLayer/VBoxContainer/NinePatchRect/CheckBox.button_pressed = false
	pass
func _on_back_button_pressed() -> void:
	Stats.musicpos = $MenuMusic.get_playback_position()
	Stats.load_scene('idle')
	pass 
func _on_resolution_pressed() -> void:
	$CanvasLayer/VBoxContainer/resolution/Label.text = "It doesn't work but its the thought that counts"
	$CanvasLayer/PopupMenu.position = Vector2(968,416)
	if $CanvasLayer/PopupMenu.visible == true:
		$CanvasLayer/PopupMenu.hide()
	else:
		$CanvasLayer/PopupMenu.show()
	pass # Replace with function body.
func _on_p_pressed() -> void:
	DisplayServer.window_set_size(Vector2i(1960,1080))
	pass 
func _on_720p_pressed() -> void:
	DisplayServer.window_set_size(Vector2i(1280,720))
	pass
func _on_h_slider_value_changed(value: float) -> void:
	Save.stats['volume'] = value
	AudioServer.set_bus_volume_db(0,(Save.stats['volume']))
	pass # Replace with function body.
func _on_menu_music_finished() -> void:
	$MenuMusic.play()
	pass
func _on_check_box_toggled(toggled_on: bool) -> void: 
	Stats.mute = toggled_on
	if Stats.mute == true:
		Save.stats['volume'] = -10
	AudioServer.set_bus_mute(0,toggled_on)
	pass
