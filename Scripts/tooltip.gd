extends PanelContainer
@onready var opacity_tween: Tween = null
@export var description:String
@export var Name :String
@export var Cost :int 
func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
		pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.text = '[b]' + Name + '[/b] :\n' + description + "\nCost: " + str(Cost)
	pass # Replace with function body.
func toggle(on:bool):
	if on:
		show()
		modulate.a = 1.0
	else:
		modulate.a - 1.0
		await tween_opacity(0.0).finished
		hide()
func tween_opacity(to:float):
	if opacity_tween:
		opacity_tween.kill()
	opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self,"modulate:a",to,0.3)
	return opacity_tween
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	size.y = 85
	pass
