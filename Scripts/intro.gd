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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if count == 1:
		timer.stop()
		count = 0
		print('finished')
		$Finished.start(1)
	pass
func start_diag():
	if diag_number == 1:
		print('diag_number1')
		Txt.text = "You're finally awake.."
		count = 0
		timer.start(0.08)
	if diag_number == 2:
		print('diag_number2')
		Txt.visible_ratio = 0
		Txt.text = "Your questions will have to go unanswered for now"
		
		timer.start(0.08)
	if diag_number == 3:
		diag_finished()
	pass
func _diag_show():
	count = min(count+0.1, 1)
	Txt.visible_ratio = min(count,1)
	pass


func _on_finished() -> void:
	diag_number += 1
	print('finishedpro')
	start_diag()
	pass # Replace with function body.


func on_portal_opened() -> void:
	Save.pkeys['newsave'] = false
	$AnimationPlayer.play("eye-close")
	var time = get_tree().create_timer(1.2)
	time.timeout.connect(leave)
	
	pass # Replace with function body.
func leave():
	Stats.fade_in = true
	Save._save()
	Stats.load_scene('idle')
