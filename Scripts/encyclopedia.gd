extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuMusic.play(Stats.musicpos)
	_on_misc_tab_pressed()
	
	pass # Replace with function body.
func _on_pressed():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_monster_tab_pressed() -> void:
	$VBoxContainer/MonsterTab.z_index = 5
	$VBoxContainer/MiscTab.z_index = 0
	$VBoxContainer/HomeTab.z_index = 0
	$MonsterTabHolder.show()
	$HelpTabHolder.hide()
	pass # ion body.


func _on_misc_tab_pressed() -> void:
	$VBoxContainer/MiscTab.z_index = 5
	$VBoxContainer/MonsterTab.z_index = 0
	$VBoxContainer/HomeTab.z_index = 0
	$MonsterTabHolder.hide()
	$HelpTabHolder.show()
	pass # Replace with function body.


func _on_exit_tab_pressed() -> void:
	Stats.musicpos = $MenuMusic.get_playback_position()
	Stats.load_scene('idle')
	pass # Replace with function body.


func _on_home_tab_pressed() -> void:
	$VBoxContainer/HomeTab.z_index = 5
	$VBoxContainer/MonsterTab.z_index = 0
	$VBoxContainer/MiscTab.z_index = 0
	$MonsterTabHolder.hide()
	pass # Replace with function body.
