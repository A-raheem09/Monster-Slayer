extends Node2D
# Called when the node enters the scene tree for the first time.
@onready var Txt = $CanvasLayer/TxtContainer/Txt
@onready var timer = $Timer
@onready var count
@onready var diag_number = 1
func _ready() -> void:
	$TextureRect.z_index = -1
	$AnimatedSprite2D.animation_finished.connect(anim_finished)
	timer.timeout.connect(_diag_show)
	timer.one_shot = false
	start_diag(diag_number)
	$AnimatedSprite2D.play("eye_open")
	pass # Replace with function body.
func anim_finished():
	Save.pkeys['newsave'] = true
	Stats.load_scene('idle')
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Txt.visible_ratio == 1:
		diag_number += 1
		$CanvasLayer/TxtContainer.hide()
		start_diag(diag_number)
	pass
func start_diag(number:int):
	if number == 1:
		Txt.text = 'Greetings...'
		Txt.visible_ratio = 0
		count = 1
		timer.start(0.1)
	if number == 2:
		Txt.text = 'Greetings...'
		Txt.visible_ratio = 0
		count = 1
		timer.start(0.1)
	pass
func _diag_show():
	count += 1
	Txt.visible_characters = count
	
	pass
