extends Button
@export var Name: String
@export var description :String
@export var variant_description : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	pass # Replace with function body.

func _on_pressed():
	$"../../../DescriptionBox/ScrollContainer/MarginContainer/RichTextLabel".text = '[b]'+ Name + ':[/b] \n' + description + '\n\n' +'[b]Variant:[/b]\n'+ variant_description + '.'
	if Stats.current_description == description and $"../../../DescriptionBox".visible == true:
		$"../../../DescriptionBox".visible = false
	else:
		$"../../../DescriptionBox".visible = true
	Stats.current_description = description
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
