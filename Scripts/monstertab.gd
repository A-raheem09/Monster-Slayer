extends Button
@export var Name: String
@export var description :String
@export var discovered : bool
@export var varname: String
@export var level1 : String
@export var level2 : String
@export var level3 : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var text = '[b]'+ Name + ':[/b] \n' + description + '\n' 
	if Save.stats[varname+'Killed'] >= 10:
		text = text + level1 + '\n'
		if Save.stats[varname+'Killed'] >= 25:
			text = text + level2 + '\n'
			if Save.stats[varname+'Killed'] >= 50:
				text = text + level3 + '\n'
	pressed.connect(_on_pressed)
	discovered = Save.pkeys[varname+'Disc']
	if discovered == false:
		visible = false
	pass # Replace with function body.

func _on_pressed():
	$"../../../DescriptionBox/ScrollContainer/MarginContainer/RichTextLabel".text = text
	if Stats.current_description == description and $"../../../DescriptionBox".visible == true:
		$"../../../DescriptionBox".visible = false
	else:
		$"../../../DescriptionBox".visible = true
	Stats.current_description = description
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
