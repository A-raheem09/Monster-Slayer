extends Control

@onready var Mucus = $MonsterTabHolder/ScrollContainer/VBoxContainer/Mucus
@onready var Monst_Spdr = $MonsterTabHolder/ScrollContainer/VBoxContainer/MonstSpider
@onready var Goblin = $MonsterTabHolder/ScrollContainer/VBoxContainer/Goblin
@onready var Orc = $MonsterTabHolder/ScrollContainer/VBoxContainer/Orc
@onready var BugBear = $MonsterTabHolder/ScrollContainer/VBoxContainer/Bugbear
@onready var Ent = $MonsterTabHolder/ScrollContainer/VBoxContainer/Ent
@onready var Shade = $MonsterTabHolder/ScrollContainer/VBoxContainer/Shade
@onready var Fiend = $MonsterTabHolder/ScrollContainer/VBoxContainer/Fiend
@onready var Dragon = $MonsterTabHolder/ScrollContainer/VBoxContainer/Dragon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_misc_tab_pressed()
	Mucus.pressed.connect(_on_mucus_pressed)
	Monst_Spdr.pressed.connect(_on_monstspdr_pressed)
	Goblin.pressed.connect(_on_goblin_pressed)
	Orc.pressed.connect(_on_orc_pressed)
	BugBear.pressed.connect(_on_bugbear_pressed)
	Ent.pressed.connect(_on_ent_pressed)
	Shade.pressed.connect(_on_shade_pressed)
	Fiend.pressed.connect(_on_fiend_pressed)
	Dragon.pressed.connect(_on_dragon_pressed)
	pass # Replace with function body.
func _on_bugbear_pressed():
	if $MonsterTabHolder/BugBearBox.visible:
		$MonsterTabHolder/BugBearBox.hide()
	else:
		$MonsterTabHolder/BugBearBox.show()
func _on_ent_pressed():
	if $MonsterTabHolder/EntBox.visible:
		$MonsterTabHolder/EntBox.hide()
	else:
		$MonsterTabHolder/EntBox.show()
func _on_shade_pressed():
	if $MonsterTabHolder/ShadeBox.visible:
		$MonsterTabHolder/ShadeBox.hide()
	else:
		$MonsterTabHolder/ShadeBox.show()
func _on_fiend_pressed():
	if $MonsterTabHolder/FiendBox.visible:
		$MonsterTabHolder/FiendBox.hide()
	else:
		$MonsterTabHolder/FiendBox.show()
	pass
func _on_dragon_pressed():
	if $MonsterTabHolder/DragonBox.visible:
		$MonsterTabHolder/DragonBox.hide()
	else:
		$MonsterTabHolder/DragonBox.show()
func _on_goblin_pressed():
	if $MonsterTabHolder/GoblinBox.visible:
		$MonsterTabHolder/GoblinBox.hide()
	else:
		$MonsterTabHolder/GoblinBox.show()
func _on_orc_pressed():
	if $MonsterTabHolder/OrcBox.visible:
		$MonsterTabHolder/OrcBox.hide()
	else:
		$MonsterTabHolder/OrcBox.show()
func _on_mucus_pressed():
	if $MonsterTabHolder/MucusBox.visible:
		$MonsterTabHolder/MucusBox.hide()
	else:
		$MonsterTabHolder/MucusBox.show()
	pass
func _on_monstspdr_pressed():
	if $MonsterTabHolder/MonstSpider.visible:
		$MonsterTabHolder/MonstSpider.hide()
	else:
		$MonsterTabHolder/MonstSpider.show()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_monster_tab_pressed() -> void:
	$VBoxContainer/MonsterTab.z_index = 5
	$VBoxContainer/MiscTab.z_index = 0
	$VBoxContainer/HomeTab.z_index = 0
	$MonsterTabHolder.show()
	pass # Replace with function body.


func _on_misc_tab_pressed() -> void:
	$VBoxContainer/MiscTab.z_index = 5
	$VBoxContainer/MonsterTab.z_index = 0
	$VBoxContainer/HomeTab.z_index = 0
	$MonsterTabHolder.hide()
	pass # Replace with function body.


func _on_exit_tab_pressed() -> void:
	Stats.load_scene('idle')
	pass # Replace with function body.


func _on_home_tab_pressed() -> void:
	$VBoxContainer/HomeTab.z_index = 5
	$VBoxContainer/MonsterTab.z_index = 0
	$VBoxContainer/MiscTab.z_index = 0
	$MonsterTabHolder.hide()
	pass # Replace with function body.
