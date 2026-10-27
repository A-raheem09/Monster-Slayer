extends Node
var Max_Health = 0
var Health = 0
var health_mult = 1 * Save.stats['Difficulty']/10
var repeat_number = 0
var current_monster : MStats
var dark_blast_mult 
var necro_percent 
var necro_dmg
var necro_cost
var necro_on:bool
var db_cost
var monster_roll : int
@export var Mucus : MStats
@export var Spider : MStats
@export var Goblin : MStats
@export var Orc : MStats
@export var Bugbear : MStats
@export var Ent : MStats
@export var Shade : MStats
@export var Fiend : MStats
@export var Dragon : MStats
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
@onready var max_mana = int(Save.stats['Mana'] * Save.stats['SummonMult'])
@onready var exp_boost : int
@onready var boost_on = false
@onready var notif_amount: int
func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	$AnimationPlayer.play("fade_in")
	var timer = get_tree().create_timer(1)
	timer.timeout.connect(loaded_in)
func loaded_in():
	Summon_time.start(max_mana)
	summon_bar.max_value = max_mana
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			damage_taken()
func initialiser(): 
	initiliase_magic()
	$CanvasLayer/Notification.hide()
	if Save.skills[9] != 1:
		$MagicSpells.hide()
		$Necromancy.hide()
	Save.stats['ExpReq'] = 10 + Save.stats['Level'] * exp_increase
	if Save.stats['Difficulty'] == 1:
		Stats.current_biome = Stats.biome.Plains
		$ControlTut.text = 'Press the Spacebar to deal damage'
		$TimeTut.text = 'Every second you remain outside drains 1 Mana so make sure to keep an eye on the bar'
	notif_amount = 1
	Stats.run_luck = randi_range(1,3) * Save.stats['Difficulty']/50
	level.text = "Level: " + str(Save.stats['Level'])
	Stats.update_damage(damage)
	diff.text = "Difficulty: " + str(Save.stats['Difficulty'])
	monster_health.max_value = Max_Health
	monster_health.value = Health
	biome_spawn()
func Monster_killed(): 
	var exp_gained = (current_monster.experience_dropped + Save.stats['Difficulty']) * Save.stats['ExpMult']
	Stats.add_kills(current_monster.varname)
	Save.stats['Difficulty'] += 1
	diff.text = "Difficulty: " + str(Save.stats['Difficulty'])
	if Save.stats['Level'] < Stats.max_level:
		if boost_on:
			Save.stats['Exp'] +=  exp_gained * exp_boost
		else:
			Save.stats['Exp'] += exp_gained
		if Save.stats['Exp'] >= Save.stats['ExpReq']:
			level_up()
	if (Save.stats['Difficulty']) in named_spawn:
		named_spawner()
	else:
		biome_spawn()
func _process(_delta:float):
	summon_bar.value = int(Summon_time.time_left)
	if summon_bar.value != 0:
		if Health <= 0:
			Monster_killed()
	if Save.stats['Difficulty'] > 1:
		$ControlTut.hide()
		$TimeTut.hide()
func damage_taken():
	Health -= Stats.damage
	monster_health.max_value = Max_Health
	monster_health.value = Health #update healthbar
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://idle.tscn")
func level_up():
	Save.stats['Exp'] -= Save.stats['Expreq']
	lvl_notif()
	$ControlTut.text = ""
	Save.stats['Level'] += 1
	$CanvasLayer/LvlHolder/Level.text = 'Level: ' + str(Save.stats['Level'])
	Save.stats['Points'] += 2
	Save.stats['SPoints'] += 1
	Save.stats['ExpReq'] = 10 + Save.stats['Level'] * exp_increase
func monster_spawn(): #OUTDATED
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
					spawn(Mucus)
			elif croll == 2:
				spawn(Goblin)
			else:
				spawn(Spider)
		elif rng >= 500 and rng < 850: # 300-850 = Rare
			var rroll = randi_range(1,3)
			if rroll == 3:
				spawn(Ent)
			elif rroll == 2:
				spawn(Orc)
			else:
				spawn(Bugbear)
		elif rng >= 850 and rng <= 1100: # 850 - 1100 = Legends
			var lroll = randi_range(1,4)
			if lroll <= 3:
				spawn(Shade)
			else:
				spawn(Fiend)
		elif rng > 1100:  #1100+ = Mythicals
			spawn(Dragon)
func named_spawner():
	if Save.stats['Difficulty'] == named_spawn[0]:
		spawn(Markus)
	elif Save.stats['Difficulty'] == named_spawn[1]:
		spawn(Orc_Warlord)
	elif Save.stats['Difficulty'] == named_spawn[2]:
		spawn(Vordt)
func spawn(Name:MStats):
	if Save.pkeys[Name.varname+'Disc'] == false:
		Save.pkeys[Name.varname+'Disc'] = true
	if (Save.stats['Difficulty']) in named_spawn:
		named_spawner()
	else:
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
				match Name.rarity: #set color of name
					0: monster_name.modulate= Color(0.93, 0.93, 0.93, 1.0)
					1: monster_name.modulate= Color(0.247, 0.792, 0.333, 1.0)
					2: monster_name.modulate= Color(0.941, 0.075, 0.196, 1.0)
					3: monster_name.modulate= Color(0.599, 0.003, 0.905, 1.0)
			Max_Health = Name.max_health * Save.stats['Difficulty']/25
			if Max_Health <= 10:
				Max_Health = 10
			Health = Max_Health
			monster_health.max_value = Max_Health
			monster_health.value = monster_health.max_value
	print(Name.name)
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
		0: exp_boost = 1.5
		1: exp_boost = 2
		2: exp_boost = 2.5
		3: exp_boost = 3
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
	elif $CanvasLayer/Notification/NotifTimer.is_stopped():
		$CanvasLayer/Notification/NotifTimer.start(1.75)
		notif_amount = 1
		$CanvasLayer/Notification/Notification.text = 'Level Up!'
		$CanvasLayer/Notification.show()
		$CanvasLayer/Notification/Notification2.hide()
		
	else:
		$CanvasLayer/Notification/NotifTimer.start(1.25)
		notif_amount += 1
		$CanvasLayer/Notification/Notification.text = 'Level Up!'
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
func biome_spawn():
	match Stats.current_biome:
		Stats.biome.Plains: plains_spawn()
		Stats.biome.Forest: forest_spawn()
		Stats.biome.Cave: cave_spawn()
		Stats.biome.Highlands: highland_spawn()
		Stats.biome.MountainRange: mountain_spawn()
func plains_spawn():
	monster_roll = randi_range(0,500) + (Stats.run_luck * 1.5)
	if 0 <= monster_roll and monster_roll <= 250:
		var croll = randi_range(1,3)
		if croll == 1:
			var mroll = randi_range(1,100)
			if mroll == 100:
				Markus.max_health = 60 * Stats.monsters_killed
				Markus.experience_dropped = 5 + Stats.monsters_killed
				spawn(Markus)
			else:
				spawn(Mucus)
		elif croll == 2:
			spawn(Goblin)
		elif croll ==3:
			spawn(Spider)
	elif monster_roll > 250 and monster_roll <= 450:
		var rroll = randi_range(1,4)
		print(rroll)
		if rroll == 1 or rroll == 2:
			spawn(Orc)
		elif rroll == 3:
			spawn(Ent)
		elif rroll == 4:
			spawn(Bugbear)
	elif monster_roll > 450:
		var lroll = randi_range(0,100)
		if lroll < 50:
			spawn(Ent)
		elif lroll>= 50 and lroll <= 99:
			spawn(Orc)
		elif lroll == 100:
			spawn(Dragon)
func forest_spawn():
	monster_roll = randi_range(0,500) + (Stats.run_luck * 1.5)
	if monster_roll >= 0 and monster_roll <= 250:
		var croll = randi_range(1,3)
		if croll == 1:
			var mroll = randi_range(1,100)
			if mroll + Stats.run_luck == 100:
				Markus.max_health = 60 * Stats.monsters_killed
				Markus.experience_dropped = 5 + Stats.monsters_killed
		elif croll == 2:
			spawn(Goblin)
		elif croll == 3:
			spawn(Spider)
	elif monster_roll > 250 and monster_roll <= 450:
		var rroll = randi_range(1,3)
		if rroll == 1:
			spawn(Bugbear)
		elif rroll > 1 and rroll <= 3:
			spawn(Ent)
	elif monster_roll > 450:
		var lroll = randi_range(1,10)
		if lroll >= 8:
			spawn(Fiend)
		elif lroll <= 3:
			spawn(Orc)
		elif lroll > 3 and lroll <= 7:
			spawn(Shade)
func cave_spawn():

	monster_roll = randi_range(0,500) + (Stats.run_luck * 1.5)
	if monster_roll >= 0 and monster_roll <= 150:
		spawn(Spider)
	elif monster_roll > 150 and monster_roll <= 400:
		var rroll = randi_range(1,2)
		if rroll == 1:
			spawn(Mucus)
		if rroll == 2:
			spawn(Goblin)
	elif monster_roll > 400:
		var lroll = randi_range(1,2)
		if lroll == 1:
			spawn(Shade)
		elif lroll == 2:
			spawn(Fiend)
func highland_spawn():
	monster_roll = randi_range(0,500) + (Stats.run_luck * 1.5)
	if monster_roll >= 0 and monster_roll <= 300:
		var rroll = randi_range(1,5)
		if rroll == 1:
			spawn(Ent)
		elif rroll == 2:
			spawn(Orc)
		elif rroll == 3:
			spawn(Bugbear)
		else:
			spawn(Goblin)
		pass
	elif monster_roll > 300:
		var lroll = randi_range(1,5)
		if lroll == 5:
			spawn(Dragon)
		elif lroll < 5:
			spawn(Fiend)
func mountain_spawn():
	var roll = randi_range(1,3)
	if roll == 1:
		spawn(Shade)
	else:
		spawn(Dragon)
