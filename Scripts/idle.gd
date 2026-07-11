extends Control
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func _on_inventory_pressed() -> void:
	get_tree().change_scene_to_file("res://inventory.tscn") # goes to inventory
	


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")





func _on_save_pressed() -> void:
	Save._save()
	pass


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Options.tscn")
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
