extends TextureButton
class_name SkillNode
@onready var Skilllevel = $SkillLevel
@onready var SkillBranch = $SkillBranch
@onready var tooltip  = $Tooltip
@export var MaxLevel:int 
@export var Cost : int 
@export var stat_to_change : String
@export var change_percent : float
@export var upgrade_number : int
var opacity_tween: Tween = null
var level :int = 0:
	set(value):
		level = value
		Skilllevel.text = str(level) + '/' + str(MaxLevel)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Skilllevel.text = str(Save.skills[upgrade_number]) + '/' + str(MaxLevel)
	var bitmap = BitMap.new()
	var image = texture_normal.get_image()
	var skills = get_children()
	for skill in skills:
		if (skill is TextureButton) and Save.skills[upgrade_number] == MaxLevel:
			skill.disabled = false
	bitmap.create_from_image_alpha(image)
	texture_click_mask = bitmap
	if get_parent() is SkillNode or get_parent() is MagicNode:
		SkillBranch.add_point(self.global_position + self.size/2)
		SkillBranch.add_point(get_parent().global_position + get_parent().size/2)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Skilllevel.text = str(Save.skills[upgrade_number]) + '/' + str(MaxLevel)
	pass
func upgrade():
	Save.stats[stat_to_change] += change_percent

func _on_pressed() -> void:
	if Save.stats['spoints'] >= Cost and (Save.skills[upgrade_number] + 1) <= MaxLevel:
		Save.stats['spoints'] -= Cost
		Save.skills[upgrade_number] += 1
		upgrade()
	var skills = get_children()
	for skill in skills:
		if skill is TextureButton and Save.skills[upgrade_number] == MaxLevel:
			skill.disabled = false
	pass # Replace with function body.

func _on_mouse_exited():
	if disabled:
		if not get_parent().disabled:
			tooltip.toggle(false)
	else:
		tooltip.toggle(false)
func _on_mouse_entered() -> void:
	if disabled:
		if not get_parent().disabled:
			tooltip.toggle(true)
	else:
		tooltip.toggle(true)
	pass # Replace with function body.
