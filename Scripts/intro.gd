extends Node2D
# Called when the node enters the scene tree for the first time.
@onready var Txt = $CanvasLayer/TxtContainer/Txt
@onready var timer = $Timer
@onready var count
@onready var diag_number = 1
func _ready() -> void:
	$TextureRect.z_index = -30
	$AnimatedSprite2D.visible = false
	timer.timeout.connect(_diag_show)
	timer.one_shot = false
	start_diag()
	$Button.pressed.connect(leave)
	
	pass # Replace with function body.
func diag_finished():
	$AnimationPlayer.play("eye_open")
	var time = get_tree().create_timer(1)
	time.timeout.connect(eye_open_finished)
	$CanvasLayer/TxtContainer.visible = false
	
	
	
func eye_open_finished():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("portal_open")
	$AnimationPlayer.play("shake")
	diag_number += 1
	start_diag()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if count == 1:
		timer.stop()
		count = 0
		$Finished.start(1)
	pass
func start_diag():
	if diag_number == 1:
		Txt.text = "Where am I?..."
		count = 0
		timer.start(0.08)
	if diag_number == 2:
		Txt.visible_ratio = 0
		Txt.text = "Who Am I?..."
		timer.start(0.08)
	if diag_number == 3:
		Txt.visible_ratio = 0
		Txt.text = "...I feel like death.."
		timer.start(0.08)
	if diag_number == 4:
		Txt.visible_ratio = 0
		Txt.text = "My eyes won't open...Do I even have eyes?"
		timer.start(0.08)
	if diag_number == 5:
		Txt.visible_ratio = 0
		Txt.text = "There we go..."
		timer.start(0.08)
	if diag_number == 6:
		diag_finished()
	if diag_number == 7:
		Txt.visible_ratio = 0
		$CanvasLayer/TxtContainer.visible = true
		Txt.text = "What the hell is happening?"
		$CanvasLayer/TxtContainer/Txt.add_theme_font_size_override('1',16)
		$CanvasLayer/TxtContainer.set_position(Vector2(1528,520))
		timer.start(0.08)
	if diag_number == 8:
		$CanvasLayer/TxtContainer.visible = false
	pass
func _diag_show():
	count = min(count+0.1, 1)
	Txt.visible_ratio = min(count,1)
	pass


func _on_finished() -> void:
	diag_number += 1
	start_diag()
	pass # Replace with function body.


func on_portal_opened() -> void:
	$AnimationPlayer.play("eye-close")
	var time = get_tree().create_timer(1.2)
	time.timeout.connect(leave)
	
	pass # Replace with function body.
func leave():
	Save.pkeys['OldSave'] = true
	Stats.fade_in = true
	Save._save()
	Stats.load_scene('idle')
