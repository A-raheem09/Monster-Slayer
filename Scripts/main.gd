extends Node
var Max_Health = 0
var Health = 0
var health_mult = 1 * Save.stats['difficulty']/10
var repeat_number = 0
var current_monster
var dark_blast_mult 
var necro_percent 
var necro_dmg
var necro_cost
var necro_on:bool
var db_cost
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
@onready var necro_timer= $Necromancy/NecroTimer
@onready var named_spawn = [10,50,150]
@onready var exp_increase = 50
@onready var max_mana = int(Save.stats['mana'] * Save.stats['summon_mult'])
@onready var exp_boost : int
@onready var boost_on = false
@onready var notif_amount: int
func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	if Save.skills[9] != 1:
		$MagicSpells.hide()
		$Necromancy.hide()
	Save.stats['expreq'] = 10 + Save.stats['level'] * exp_increase
	if Save.stats['difficulty'] == 1:
		$ControlTut.text = 'Press the Spacebar to deal damage'
		$TimeTut.text = 'Every second you remain outside drains 1 Mana so make sure to keep an eye on the bar'
	Summon_time.start(max_mana)
	summon_bar.max_value = max_mana
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			damage_taken()
func initialiser(): 
	initiliase_magic()
	$CanvasLayer/Notification.hide()
	notif_amount = 1
	level.text = "Level: " + str(Save.stats['level'])
	Stats.update_damage(damage)
	diff.text = "Difficulty: " + str(Save.stats['difficulty'])
	Stats.run_luck = randi_range(1,3) * Save.stats['difficulty']/50
	monster_health.max_value = Max_Health
	monster_health.value = Health
	monster_spawn()
func Monster_killed():
	Stats.add_kills()
	Save.stats['difficulty'] += 1
	diff.text = "Difficulty: " + str(Save.stats['difficulty'])
	if Save.stats['level'] < Stats.max_level:
		if boost_on:
			Save.stats['exp'] += ((current_monster.experience_dropped + Save.stats['difficulty']) * Save.stats['exp_mult']) * exp_boost
		else:
			Save.stats['exp'] += ((current_monster.experience_dropped + Save.stats['difficulty']/2) * Save.stats['exp_mult'])
		if Save.stats['exp'] >= Save.stats['expreq']:
			level_up()
	if (Save.stats['difficulty']) in named_spawn:
		named_spawner()
	else:
		monster_spawn()
func _process(_delta:float):
	summon_bar.value = int(Summon_time.time_left)
	if Health <= 0:
		await health_update()
		Monster_killed()
	if Save.stats['difficulty'] > 1:
		$ControlTut.hide()
		$TimeTut.hide()
func damage_taken():
	Health -= Stats.damage
	monster_health.max_value = Max_Health
	monster_health.value = Health #update healthbar
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://idle.tscn")
func level_up():
	Save.stats['exp'] -= Save.stats['expreq']
	lvl_notif()
	$ControlTut.text = ""
	Save.stats['level'] += 1
	$CanvasLayer/LvlHolder/Level.text = 'Level: ' + str(Save.stats['level'])
	Save.stats['points'] += 2
	Save.stats['spoints'] += 1
	Save.stats['expreq'] = 10 + Save.stats['level'] * exp_increase
func monster_spawn():
	if (Save.stats['difficulty']) in named_spawn:
		named_spawner()
	else:
		var rng = randi_range(0,850) + (Stats.run_luck * 25) # 0 < Common < 300,,  
		if rng < 500 and rng >= 0: 
			var croll = randi_range(1,3)
			if croll == 1:
				var mroll = randi_range(1,100)
				if mroll + Stats.run_luck == 100:
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
			var lroll = randi_range(1,4)
			if lroll <= 3:
				spawn(shade)
			else:
				spawn(fiend)
		elif rng > 1100:  #1100+ = Mythicals
			spawn(dragon)
func named_spawner():
	if Save.stats['difficulty'] == named_spawn[0]:
		spawn(Markus)
	elif Save.stats['difficulty'] == named_spawn[1]:
		spawn(Orc_Warlord)
	elif Save.stats['difficulty'] == named_spawn[2]:
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
			match Name.rarity:
				0: monster_name.modulate= Color(0.93, 0.93, 0.93, 1.0)
				1: monster_name.modulate= Color(0.247, 0.792, 0.333, 1.0)
				2: monster_name.modulate= Color(0.941, 0.075, 0.196, 1.0)
				3: monster_name.modulate= Color(0.599, 0.003, 0.905, 1.0)
		Max_Health = Name.max_health * Save.stats['difficulty']/25
		if Max_Health <= 10:
			Max_Health = 10
		Health = Max_Health
		monster_health.max_value = Max_Health
		monster_health.value = monster_health.max_value
func _on_back_button_pressed() :
	get_tree().change_scene_to_file("res://Idle.tscn")
	pass # Replace with function body.
func _on_audio_stream_player_2d_finished() -> void:
	$Music.play()
	pass # Replace with function body.
func _on_time_left_timeout() -> void:
	get_tree().change_scene_to_file("res://Idle.tscn")
	pass # Replace with function body.
func _on_notif_timer_timeout() -> void:
	$CanvasLayer/Notification.hide()
	pass # Replace with function body.
func initiliase_magic():
	#darkblast setup
	match Save.skills[10]:
		0: dark_blast_mult = 10
		1: dark_blast_mult = 20
		2: dark_blast_mult = 50
		3: dark_blast_mult = 100
	match Save.skills[10]:
		0: db_cost = 10
		1: db_cost = 15
		2: db_cost = 25
		3: db_cost = 40
	var db = dark_blast_mult * 100
	$"MagicSpells/Dark Blast/Tooltip".Effect = 'Does ' + str(db) +'% of your regular damage per use'
	#expboost setup
	match Save.skills[11]:
		0: exp_boost = 2
		1: exp_boost = 3
		2: exp_boost = 4
		3: exp_boost = 5
	$MagicSpells/ExpBoost/Tooltip.Effect = " " + str(exp_boost * 100) + "% Experience Gain For The Next 30 Seconds"
	match Save.skills[13]:
		0: necro_percent = 0.02
		1: necro_percent = 0.04
		2: necro_percent = 0.06
		3: necro_percent = 0.12
	match Save.skills[13]:
		0: necro_cost = 1 
		1: necro_cost = 2
		2: necro_cost = 4
		3: necro_cost = 6
	$Necromancy/Tooltip.Effect = str(int(necro_percent * 100)) + "% of your damage a second"
	$Necromancy/Tooltip.Cost = str(necro_cost) + " mana a second"
	necro_timer.timeout.connect(_on_necro_timeout)
	necro_on = false
func _on_dark_blast_pressed() -> void:
	var mana_left = Summon_time.time_left
	if mana_left >= db_cost:
		Summon_time.start(mana_left - db_cost)
		Health -= (Stats.damage * dark_blast_mult)
		monster_health.value = Health
	else:
		mana_notif()
	pass # Replace with function body.
func _on_exp_boost_pressed() -> void:
	var cost = 10
	var mana_left = Summon_time.time_left
	if not boost_on:
		if mana_left >= cost:
			boost_on = true
			Summon_time.start(mana_left - cost)
			var boost_time = get_tree().create_timer(30)
			boost_time.timeout.connect(on_expboost_timeout)
		else:
			mana_notif()
	pass # Replace with function body.
func on_expboost_timeout():
	boost_on = false
func health_update():
	monster_health.max_value = Max_Health
	monster_health.value = Health
func lvl_notif():
	if $CanvasLayer/Notification/Notification.text == 'No Mana':
		notif_amount = 1
	$CanvasLayer/Notification/Notification.text = 'Level Up!'
	if $CanvasLayer/Notification/NotifTimer.is_stopped():
		$CanvasLayer/Notification/NotifTimer.start(1.75)
		notif_amount = 1
		$CanvasLayer/Notification.show()
		$CanvasLayer/Notification/Notification2.hide()
		
	else:
		$CanvasLayer/Notification/NotifTimer.start(1)
		notif_amount += 1
		$CanvasLayer/Notification/Notification2/Notification.text = "x" + str(notif_amount)
		$CanvasLayer/Notification/Notification2.show()
	pass

func _on_necro_timeout():
	necro_dmg = Stats.damage * necro_percent
	var mana_left = Summon_time.time_left
	if mana_left >= necro_cost:
		Summon_time.start(mana_left - necro_cost)
		Health -= necro_dmg
		health_update()
	else:
		mana_notif()
		necro_on = false
	pass
func _on_necromancy_pressed() -> void:
	if necro_on:
		necro_on = false
		necro_timer.stop()
	else:
		necro_on = true
		necro_timer.start(1)
	pass # Replace with function body.
func mana_notif():
	if $CanvasLayer/Notification/Notification.text == 'Level Up!':
		notif_amount = 1
	$CanvasLayer/Notification/Notification.text = 'No Mana'
	$CanvasLayer/Notification/NotifTimer.start(1.75)
	$CanvasLayer/Notification.show()
	$CanvasLayer/Notification/Notification2.hide()
