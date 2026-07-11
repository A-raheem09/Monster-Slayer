extends Node
var Max_Health = 0
var Health = 0
var health_mult = 1 * Stats.difficulty/10
@export var slime : MStats
@export var goblin : MStats
@export var orc : MStats
@export var ent : MStats
@export var shade : MStats
@export var fiend : MStats
@export var dragon : MStats
@onready var monster_health = $CanvasLayer/HealthBar
@onready var Summon_time = $TimeLeft
@onready var summon_bar = $CanvasLayer/SummonHolder/SummonBar
@onready var damage = $CanvasLayer/DmgHolder/Damage
@onready var level = $CanvasLayer/LvlHolder/Level
@onready var diff = $CanvasLayer/DiffHolder/Difficulty
@onready var monster_name = $CanvasLayer/Monster_name
func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	for i in Save.stats:
		print(Save.stats[i])
	Summon_time.start(30)
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			damage_taken()
func initialiser(): 
	level.text = "Level: " + str(Stats.level)
	damage.text = "Damage: " + str(Stats.damage)
	diff.text = "Difficulty: " + str(Stats.difficulty)
	Stats.run_luck = randi_range(1,5) + Stats.difficulty/100
	monster_health.max_value = Max_Health
	monster_health.value = Health
	monster_spawn()
func Monster_killed():
	Stats.add_kills()
	monster_spawn()
func _process(_delta:float):
	if Health <= 0:
		Monster_killed()
	summon_bar.value = (int(Summon_time.time_left) / Summon_time.wait_time) * 100
func damage_taken():
	Health -= Stats.damage
	monster_health.max_value = Max_Health
	monster_health.value = Health #update healthbar
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://idle.tscn")
func level_up():
	Stats.level += 1
	Stats.skill_points += 3
func monster_spawn():
	Stats.difficulty += 1
	diff.text = "Difficulty: " + str(Stats.difficulty)
	var rng = randi_range(0,850) + Stats.run_luck # 0 < Common < 300,,  
	if rng < 500 and rng >= 0: 
		var croll = randi_range(1,2)
		if croll == 1:
			spawn(slime)
		else:
			spawn(goblin)
	if rng >= 500 and rng < 850: # 300-850 = Rare
		var rroll = randi_range(1,2)
		if rroll == 2:
			spawn(ent)
		else:
			spawn(orc)
	if rng >= 850 and rng <= 1100: # 850 - 1100 = Legends
		var lroll = randi_range(1,5)
		if lroll <= 4:
			spawn(shade)
		else:
			spawn(fiend)
	if rng > 1100:  #1100+ = Mythicals
		spawn(dragon)

func spawn(Name:MStats):
	monster_name.text = Name.name
	Max_Health = Name.max_health * Stats.difficulty/30
	Health = Max_Health
	monster_health.max_value = Max_Health
	monster_health.value = monster_health.max_value

func _on_back_button_pressed() :
	get_tree().change_scene_to_file("res://Idle.tscn")
	pass # Replace with function body.
