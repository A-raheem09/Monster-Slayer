extends Node2D
var ispressed : bool
const drag_speed = 0.15
const zoom_speed = 0.1
const min_zoom = 2.0
const max_zoom = 3.5
const max_x = 1960
const mincoords = 0
const max_y = 1080
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and ispressed:
		if (global_position - event.relative * drag_speed).x <= max_x and (global_position - event.relative * drag_speed).x >= mincoords and (global_position - event.relative * drag_speed).y <= max_y and (global_position - event.relative * drag_speed).y >= mincoords:
			global_position -= event.relative * drag_speed

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			ispressed = event.pressed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Camera2D.zoom = Vector2.ONE * max(min_zoom,$Camera2D.zoom.x - zoom_speed) 
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Camera2D.zoom = Vector2.ONE * min(max_zoom,$Camera2D.zoom.x + zoom_speed)
