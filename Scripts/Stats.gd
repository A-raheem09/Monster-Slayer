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
var mute : bool
var level_scenes = [
	preload("res://Idle.tscn"),
	preload("res://Options.tscn"),
	preload("res://main.tscn"),
	preload("res://inventory.tscn")]
var audio = null
var musicpos = 0
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
		'inv':
			get_tree().change_scene_to_file("res://inventory.tscn")
		'skills':
			get_tree().change_scene_to_file("res://skill_tree.tscn")
			
	pass
