extends Node
var Max_Health = 0
var Health = 0
var health_mult = 1 * Save.stats['difficulty']/10
var repeat_number = 0
var current_monster
@export var slime : MStats
@export var monstrous_spider : MStats
@export var goblin : MStats
@export var orc : MStats
@export var bugbear : MStats
@export var ent : MStats
@export var shade : MStats
@export var fiend : MStats
@export var dragon : MStats
@export var Markus:MStats
@export var Orc_Warlord:MStats
@export var Vordt:MStats
@export var Lucifer:MStats
@export var Shurikan:MStats
@onready var monster_health = $CanvasLayer/HealthBar
@onready var Summon_time = $TimeLeft
@onready var summon_bar = $CanvasLayer/SummonHolder/SummonBar
@onready var damage = $CanvasLayer/DmgHolder/Damage
@onready var level = $CanvasLayer/LvlHolder/Level
@onready var diff = $CanvasLayer/DiffHolder/Difficulty
@onready var monster_name = $CanvasLayer/NameHolder/Monster_name
@onready var named_spawn = [10,50,100]
@onready var exp_increase = 50

func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	Save.stats['expreq'] = 10 + Save.stats['level'] * exp_increase
	if Save.stats['difficulty'] == 1:
		$Label.text = 'Press the Spacebar or click anywhere on the screen to deal damage'
		$Label2.text = 'The summon time bar acts as a time limit so make sure to keep an eye on it'
	Summon_time.start(30 * Save.stats['summon_mult'])
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			damage_taken()
func initialiser(): 
	level.text = "Level: " + str(Save.stats['level'])
	damage.text = "Damage: " + str(Stats.damage)
	diff.text = "Difficulty: " + str(Save.stats['difficulty'])
	Stats.run_luck = randi_range(1,5) + Save.stats['difficulty']/100
	monster_health.max_value = Max_Health
	monster_health.value = Health
	monster_spawn()
func Monster_killed():
	Stats.add_kills()
	if Save.stats['level'] < Stats.max_level:
		Save.stats['exp'] += (current_monster.experience_dropped + Save.stats['difficulty']) * Save.stats['exp_mult'] 
		if Save.stats['exp'] >= Save.stats['expreq']:
			level_up()
	if (Save.stats['difficulty'] + 1) in named_spawn:
		named_spawner()
	else:
		monster_spawn()
func _process(_delta:float):
	if Health <= 0:
		Monster_killed()
	summon_bar.value = (int(Summon_time.time_left) / Summon_time.wait_time) * 100
	if Save.stats['difficulty'] > 1:
		$Label.text = ''
		$Label2.text = ''
func damage_taken():
	Health -= Stats.damage
	monster_health.max_value = Max_Health
	monster_health.value = Health #update healthbar
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://idle.tscn")
func level_up():
	Save.stats['exp'] -= Save.stats['expreq']
	$Notification.show()
	$Notification/NotifTimer.start(2)
	Save.stats['level'] += 1
	$CanvasLayer/LvlHolder/Level.text = 'Level: ' + str(Save.stats['level'])
	Save.stats['points'] += 1
	Save.stats['spoints'] += 1
	Save.stats['expreq'] = 10 + Save.stats['level'] * exp_increase
func monster_spawn():
	if (Save.stats['difficulty'] + 1) in named_spawn:
		named_spawner()
	else:
		var rng = randi_range(0,850) + Stats.run_luck # 0 < Common < 300,,  
		if rng < 500 and rng >= 0: 
			var croll = randi_range(1,3)
			if croll == 1:
				var mroll = randi_range(1,100)
				if mroll == 100:
					Markus.max_health = 60 * Stats.monsters_killed
					Markus.experience_dropped = 5 + Stats.monsters_killed
				else:
					spawn(slime)
			elif croll == 2:
				spawn(goblin)
			else:
				spawn(monstrous_spider)
		elif rng >= 500 and rng < 850: # 300-850 = Rare
			var rroll = randi_range(1,3)
			if rroll == 3:
				spawn(ent)
			elif rroll == 2:
				spawn(orc)
			else:
				spawn(bugbear)
		elif rng >= 850 and rng <= 1100: # 850 - 1100 = Legends
			var lroll = randi_range(1,5)
			if lroll <= 4:
				spawn(shade)
			else:
				spawn(fiend)
		elif rng > 1100:  #1100+ = Mythicals
			spawn(dragon)
func named_spawner():
	if Save.stats['difficulty'] + 1 == named_spawn[0]:
		spawn(Markus)
	elif Save.stats['difficulty'] + 1== named_spawn[1]:
		spawn(Orc_Warlord)
	elif Save.stats['difficulty'] + 1 == named_spawn[2]:
		spawn(Vordt)
func spawn(Name:MStats):
	var last_monster = monster_name.text 
	if last_monster == Name.name:
		repeat_number += 1
	else:
		repeat_number = 0
	if repeat_number > 2:
		monster_spawn()
	else:
		current_monster = Name
		monster_name.text = Name.name
		if Name.named:
			monster_name.modulate = Color.GOLD
		else:
			monster_name.modulate = Color(0.932, 0.929, 0.929)
		Max_Health = Name.max_health * Save.stats['difficulty']/30
		if Max_Health <= 10:
			Max_Health = 10
		Health = Max_Health
		monster_health.max_value = Max_Health
		monster_health.value = monster_health.max_value
		Save.stats['difficulty'] += 1
		diff.text = "Difficulty: " + str(Save.stats['difficulty'])
func _on_back_button_pressed() :
	get_tree().change_scene_to_file("res://Idle.tscn")
	pass # Replace with function body.
func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.
func _on_time_left_timeout() -> void:
	get_tree().change_scene_to_file("res://Idle.tscn")
	pass # Replace with function body.
func _on_notif_timer_timeout() -> void:
	$Notification.hide()
	pass # Replace with function body.
