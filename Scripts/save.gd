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
]
var pkeys:Dictionary = {
	
}
var stats = {
	'difficulty':0,
	'damage':1,
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
	file.close()
func _load():
	if FileAccess.file_exists(FILE_PATH):
		var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
		var data : Array = file.get_var()
		for i in range(data.size()):
			if skills.has(i):
				skills[i] = data[i]
		var stat : Dictionary = file.get_var()
		for i in stat:
			stats[i] = stat[i]
		file.close()
