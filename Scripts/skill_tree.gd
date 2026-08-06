extends Control
@onready var points = $Upgrade/VBoxContainer/Points/Points
@onready var sp = $Upgrade/VBoxContainer/SP_Holder/SP
@onready var dmg = $Upgrade/VBoxContainer/DmgHolder/Dmg
@onready var summon_time = $Upgrade/VBoxContainer/ST_Holder/Summon_Time
@onready var total_mana = Save.stats['mana'] * Save.stats['summon_mult']
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stats.update_label(summon_time,'Mana', total_mana)
	Stats.update_damage(dmg)
	points.text ='Stat Points : ' + str(Save.stats['points'])
	sp.text ='Skill Points : ' + str(Save.stats['spoints'])
	$CameraManager/MenuMusic.play(Stats.musicpos)
	$"Imp Buttons/Exit".connect("pressed",on_exit)
	$"Imp Buttons/Hide".connect("pressed",on_hide_press)
	if Save.stats['points'] <= 0:
		$Upgrade/VBoxContainer/ST_Holder/Summon_Time/increment.disabled = true
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = true
	else:
		$Upgrade/VBoxContainer/ST_Holder/Summon_Time/increment.disabled = false
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = false
	pass # Replace with function body.
func on_hide_press():
	if $Upgrade.visible:
		$Upgrade.hide()
	else: 
		$Upgrade.show()
	pass
func on_exit():
	Stats.musicpos = $CameraManager/MenuMusic.get_playback_position()
	Stats.load_scene('idle')
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total_mana = Save.stats['mana'] * Save.stats['summon_mult']
	if Save.stats['points'] <= 0:
		$Upgrade/VBoxContainer/ST_Holder/Summon_Time/increment.disabled = true
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = true
	else:
		$Upgrade/VBoxContainer/ST_Holder/Summon_Time/increment.disabled = false
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = false
	sp.text ='Skill Points : ' + str(Save.stats['spoints'])
	Stats.damage = Save.stats['damage'] * Save.stats['dmg_mult']
	Stats.update_damage(dmg)
	Stats.update_label(summon_time,'Mana', total_mana)
	pass

func _on_smincrement_pressed() -> void:
	if Save.stats['points'] >= 1:
		Save.stats['points'] -= 1
		Save.stats['mana'] += 5
		Stats.update_label(summon_time,'Mana', total_mana)
		Stats.update_label(points,'Stat Points',Save.stats['points'])
	pass # Replace with function body.


func _on_dmg_increment_pressed() -> void:
	if Save.stats['points'] >= 1:
		Save.stats['points'] -= 1
		Save.stats['damage'] += 1 
		Stats.damage = Save.stats['damage'] * Save.stats['dmg_mult']
		Stats.update_damage(dmg)
		Stats.update_label(points,'Stat Points',Save.stats['points'])
	pass # Replace with function body.
