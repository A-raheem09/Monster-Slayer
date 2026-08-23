extends Button
@export var Name : String
@export var description : String
@onready var label = $"../../../DescriptionBox/ScrollContainer/MarginContainer/RichTextLabel"
@onready var description_box = $"../../../DescriptionBox"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	pass # Replace with function body.

func _on_pressed():
	label.text = '[b]' + Name + ':[/b]\n' + description + '.'
	if Stats.current_description == description and description_box.visible == true:
		description_box.visible = false
	else:
		description_box.visible = true
	Stats.current_description = description
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
