extends Node

var inventory:Array = [
	
]
var stats = {
	'difficulty':0,
	'damage':1,
	'dmg_mult':1,
	'summon_mult':1,
	'level':1,
	
}
const FILE_PATH = "user://MSSaveFile.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_save()
	_load()
	_gurt()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _save():
	var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_var(inventory)
	file.store_var(stats)
	file.close()
func _load():
	if FileAccess.file_exists(FILE_PATH):
		var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
		var data : Array = file.get_var()
		for i in range(data.size()):
			if inventory.has(i):
				inventory[i] = data[i]
		var stat : Dictionary = file.get_var()
		for i in stat:
			stats[i] = stat[i]
		file.close()
func _gurt():
	Stats.damage = stats['damage']
	Stats.difficulty = stats['difficulty']
	Stats.summon_mult = stats['summon_mult']
	Stats.dmg_mult = stats['dmg_mult']
	Stats.level = stats['level']
