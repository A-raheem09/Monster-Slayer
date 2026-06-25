extends Node

var PKeys = {
	'' : false
}
var inventory = {
	'Difficulty':0,
	'Damage':10
}
const FILE_PATH = "user://MSSaveFile.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _save():
	var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_var(PKeys)
	file.store_var(inventory)
	file.close()
func _load():
	if FileAccess.file_exists(FILE_PATH):
		var file : FileAccess = FileAccess.open(FILE_PATH, FileAccess.READ)
		var data : Dictionary = file.get_var()
		for i in data:
			if PKeys.has(i):
				PKeys[i] = data[i]
		var inv : Dictionary = file.get_var()
		for i in inv:
			inventory[i] = inv[i]
		file.close()
