extends Node
@export var Difficulty = 0
@export var Damage = 10
@export var Bal = 0
@export var total_copper = 0
@export var Summon_Mult = 1
@export var Dmg_Mult = 1
@export var Health_Mult = 1
@export var Money_Mult = 1
@export var Inventory = []
@export var Mucus_Drops = {1:'Slime',2:'Slime Core',}
@export var Monsters_Killed = 0
@export var Monster_list = {'Mucus': 70,'Goblin': 120,'Orc': 200,"Ent" : 500 ,'Shade': 1000,'Fiend': 2500,'Dragon': 100000,}
@export var Monster_rarity = {'Mucus': 15 , 'Goblin': 40,'Orc' : 60 ,"Ent" : 100 ,'Shade': 140,'Fiend': 170,'Dragon': 250,}
@export var M_drops = {'Mucus': 30 , 'Goblin': 60,'Orc' : 200 ,"Ent" : 2000, 'Shade': 10000,'Fiend': 30000,'Dragon': 1500000000,}
@export var NamedHealth = {'Charlie The Slime': 100,'Orc Warlord': 500, 'Vordt The Malificent': 3000,"Lucifer": 6666 ,"Shruikan The Black Dragon": 1000000}
@export var NamedDrops = {'Charlie The Slime': 100,'Orc Warlord': 500, 'Vordt The Malificent': 3000,"Lucifer": 6666 ,"Shruikan The Black Dragon": 1000000}
var Monsters = ['Mucus','Goblin',"Ent",'Orc','Shade','Fiend','Dragon']
func Add_Kills():
	Monsters_Killed += 1 
