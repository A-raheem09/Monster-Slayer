extends Node
@export var difficulty = 0
@export var damage = 10  
@export var level = 1
@export var skill_points = 0
@export var total_copper = 0
@export var summon_mult = 1
@export var dmg_mult = 1
@export var health_mult = 1
@export var money_mult = 1
@export var inventory = []
@export var mucus_drops = {1:'Slime',2:'Slime Core',}
@export var goblin_drops = {3:'',}
@export var monsters_killed = 0
@export var monster_list = {'Mucus': 70,'Goblin': 120,'Orc': 200,"Ent" : 500 ,'Shade': 1000,'Fiend': 2500,'Dragon': 100000,}
@export var monster_rarity = {'Mucus': 30 , 'Goblin': 60,'Orc' : 100 ,"Ent" : 150 ,'Shade': 160,'Fiend': 190,'Dragon': 250,}
@export var m_drops = {'Mucus': 30 , 'Goblin': 60,'Orc' : 200 ,"Ent" : 2000, 'Shade': 10000,'Fiend': 30000,'Dragon': 1500000000,}
@export var named_health = {'Markus': 100,'Orc Warlord': 500, 'Vordt The Malificent': 3000,"Lucifer": 6666 ,"Shruikan The Black Dragon": 1000000}
@export var named_drops = {'Markus': 2,'Orc Warlord': 500, 'Vordt The Malificent': 3000,"Lucifer": 6666 ,"Shruikan The Black Dragon": 1000000}
@export var named_spawn = { 10:'Markus', 50:'Orc Warlord', 150 :'Vordt The Malificent',300: "Lucifer" , 1000:"Shruikan The Black Dragon"}
@export var run_luck : float
var monsters = ['Mucus','Goblin',"Ent",'Orc','Shade','Fiend','Dragon']
func add_kills():
	monsters_killed += 1 
