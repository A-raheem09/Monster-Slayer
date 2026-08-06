extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pass # Replace with function body.

func _on_mouse_entered():
	$Tooltip.toggle(true)
func _on_mouse_exited():
	$Tooltip.toggle(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
