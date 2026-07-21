extends Control
@onready var points = $Upgrade/VBoxContainer/Points/Points
@onready var sp = $Upgrade/VBoxContainer/SP_Holder/SP
@onready var dmg = $Upgrade/VBoxContainer/DmgHolder/Dmg
@onready var summon_time = $Upgrade/ST_Holder/Summon_Time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	summon_time.text = 'Summon Time Multiplier : ' + str(Save.stats['summon_mult'])
	dmg.text = 'Damage : ' + str(Save.stats['damage'] * Save.stats['dmg_mult'])
	points.text ='Points : ' + str(Save.stats['points'])
	sp.text ='Skill Points : ' + str(Save.stats['spoints'])
	$CameraManager/MenuMusic.play(Stats.musicpos)
	$"Imp Buttons/Exit".connect("pressed",on_exit)
	$"Imp Buttons/Hide".connect("pressed",on_hide_press)
	if Save.stats['points'] <= 0:
		$Upgrade/ST_Holder/Summon_Time/increment.disabled = true
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = true
	else:
		$Upgrade/ST_Holder/Summon_Time/increment.disabled = false
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = false
	pass # Replace with function body.
func on_hide_press():
	if $Upgrade.visible:
		$Upgrade.hide()
	else: 
		$Upgrade.show()
	pass
func on_exit():
	Stats.load_scene('idle')
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Save.stats['points'] <= 0:
		$Upgrade/ST_Holder/Summon_Time/increment.disabled = true
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = true
	else:
		$Upgrade/ST_Holder/Summon_Time/increment.disabled = false
		$Upgrade/VBoxContainer/DmgHolder/Dmg/increment.disabled = false
	sp.text ='Skill Points : ' + str(Save.stats['spoints'])
	Stats.damage = Save.stats['damage'] * Save.stats['dmg_mult']
	dmg.text = 'Damage : ' + str(Stats.damage)
	summon_time.text = 'Summon Time Multiplier : ' + str(Save.stats['summon_mult'])
	pass

func _on_smincrement_pressed() -> void:
	if Save.stats['points'] >= 1:
		Save.stats['points'] -= 1
		Save.stats['summon_mult'] += 0.2
		summon_time.text = 'Summon Time Multiplier : ' + str(Save.stats['summon_mult'])
		points.text ='Points : ' + str(Save.stats['points'])
	pass # Replace with function body.


func _on_dmg_increment_pressed() -> void:
	if Save.stats['points'] >= 1:
		Save.stats['points'] -= 1
		Save.stats['damage'] += 1 
		Stats.damage = Save.stats['damage'] * Save.stats['dmg_mult']
		dmg.text = 'Damage : ' + str(Stats.damage)
		points.text ='Points : ' + str(Save.stats['points'])
	pass # Replace with function body.
