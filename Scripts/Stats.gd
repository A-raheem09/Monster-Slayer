extends Node
@onready var total_copper = 0
@onready var damage = Save.stats['damage'] * Save.stats['dmg_mult']
@onready var run_luck :int 
@onready var monsters_killed = 0
@onready var max_dmg = 100000
@onready var max_level = 100
@onready var named_health = {'Markus': 100,'Orc Warlord': 500, 'Vordt The Malificent': 3000,"Lucifer": 6666 ,"Shruikan The Black Dragon": 1000000}
var monsters = ['Mucus','Goblin',"Ent",'Orc','Shade','Fiend','Dragon']
var current_level_scene = null
var level_scenes = [
	preload("res://Idle.tscn"),
	preload("res://Options.tscn"),
	preload("res://main.tscn"),
	preload("res://inventory.tscn")]
var audio = null
var musicpos = 0
var mute = false
var base_stats = {
	'difficulty':1,
	'damage':1,
	'mana':10,
	'dmg_mult':1,
	'summon_mult':1,
	'level':1,
	'volume':1,
	'resolutionh': 1080,
	'resolutionw':1960,
	'expreq':20,
	'exp':0,
	'exp_mult':1,
	'points':0,
	'spoints':0
	}
func add_kills():
	monsters_killed += 1 
func load_scene(level_name:String):
	
	match level_name:
		'main':
			get_tree().change_scene_to_file("res://main.tscn")
		'idle':
			get_tree().change_scene_to_file("res://Idle.tscn")
		'options':
			get_tree().change_scene_to_file("res://Options.tscn")
		'enc':
			get_tree().change_scene_to_file("res://encyclopedia.tscn")
		'skills':
			get_tree().change_scene_to_file("res://skill_tree.tscn")
		'intro':
			get_tree().change_scene_to_file("res://intro.tscn")
	if Save.stats['volume'] == -10:
		AudioServer.set_bus_mute(0,true)
	else:
		AudioServer.set_bus_volume_db(0,(Save.stats['volume']))
	pass
func update_damage(label_name:Label):
	damage = Save.stats['damage'] * Save.stats['dmg_mult']
	if Save.stats['damage'] * Save.stats['dmg_mult'] > 25:
		label_name.text = 'Damage : ' + str(int(Save.stats['damage'] * Save.stats['dmg_mult']))
	else:
		label_name.text = 'Damage : ' + str(Save.stats['damage'] * Save.stats['dmg_mult'])
func update_label(label_name:Label,stat_name:String, stat):
	label_name.text = stat_name + ' : ' + str(stat)
func reset_save():
	for i in Save.stats:
		Save.stats[i] = base_stats[i]
	for i in range(Save.skills.size()):
		Save.skills[i] = 0
	pass
