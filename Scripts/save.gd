extends Node

var skills:Array = [
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
]
var pkeys:Dictionary = {
	'OldSave':false,
	'EncOpened':false,
	'SkillTabOpened':false,
	'SlothKilled':false,
	'GluttonyKilled':false,
	'GreedKilled':false,
	'EnvyKilled':false,
	'LustKilled':false,
	'WrathKilled':false,
	'PrideKilled':false,
	'MucusDisc':false, #MucusDiscovered -> MucusDisc
	'SpiderDisc':false,
	'GoblinDisc':false,
	'OrcDisc':false,
	'BugbearDisc':false,
	'EntDisc':false,
	'ShadeDisc':false,
	'FiendDisc':false,
	'DragonDisc':false,
	
}
var stats = {
	'Difficulty':1,
	'Damage':1,
	'Mana':10,
	'DmgMult':1,
	'SummonMult':1,
	'Level':1,
	'Volume':1,
	'ResolutionH': 1080,
	'ResolutionW':1960,
	'ExpReq':20,
	'Exp':0,
	'ExpMult':1,
	'Points':0,
	'SPoints':0,
	'MucusKilled':0,
	'SpiderKilled':0,
	'GoblinKilled':0,
	'OrcKilled':0,
	'BugbearKilled':0,
	'EntKilled':0,
	'ShadeKilled':0,
	'FiendKilled':0,
	'DragonKilled':0,
}
const FILE_PATH = "user://MSSaveFile.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_save()
	_load()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func _save():
	var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_var(skills)
	file.store_var(stats)
	file.store_var(pkeys)
	file.close()
func _load():
	if FileAccess.file_exists(FILE_PATH):
		var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
		var data : Array = file.get_var()
		for i in range(data.size()):
			skills[i] = data[i]
		var stat : Dictionary = file.get_var()
		for i in stat:
			stats[i] = stat[i]

		var pkey = file.get_var()
		for i in pkey:
			pkeys[i] = pkey[i]
		file.close()
