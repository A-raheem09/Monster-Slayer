extends Node
@export var difficulty :int
@export var damage :int  
@export var level : int
@export var skill_points = 0
@export var total_copper = 0
@export var summon_mult :int
@export var dmg_mult :int
@export var monsters_killed = 0
@export var named_health = {'Markus': 100,'Orc Warlord': 500, 'Vordt The Malificent': 3000,"Lucifer": 6666 ,"Shruikan The Black Dragon": 1000000}
var monsters = ['Mucus','Goblin',"Ent",'Orc','Shade','Fiend','Dragon']
func add_kills():
	monsters_killed += 1 
