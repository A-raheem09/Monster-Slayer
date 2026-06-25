extends Node
var monster_list = {'Mucus': 70,'Goblin': 120,'Orc': 200,"Ent" : 500 ,'Shade': 1000,'Fiend': 2500,'Dragon': 100000,}
var monster_rarity = {'Mucus': 15 , 'Goblin': 40,'Orc' : 60 ,"Ent" : 100 ,'Shade': 140,'Fiend': 170,'Dragon': 250,}
var m_drops = {'Mucus': 30 , 'Goblin': 60,'Orc' : 200 ,"Ent" : 2000, 'Shade': 10000,'Fiend': 30000,'Dragon': 1500000000,}
var Max_Health = 0
var Health = 0
@onready var Monster_health = $HealthBar
@onready var Summon_time = $TimeLeft
func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	Summon_time.start(30)
func _input(event):
	if event.is_action_pressed("Attack"):
		monster_spawn()
		if Health > 0:
			damage_taken()
func initialiser(): 
	$Level.text = "Level: " + str(Stats.level)
	$Damage.text = "Damage: " + str(Stats.damage)
	$Damage.modulate = Color.GREEN_YELLOW
	$Difficulty.modulate = Color.FIREBRICK
	$Difficulty.text = "Difficulty: " + str(Stats.difficulty)
	Stats.run_luck = randf() * Stats.difficulty
	Monster_health.max_value = Max_Health
	Monster_health.value = Health
	monster_spawn()
func Monster_killed():
	Stats.add_kills()
	monster_spawn()
func _process(_delta:float):
	if Health <= 0:
		Monster_killed()
	$SummonBar.value = (int(Summon_time.time_left) / Summon_time.wait_time) * 100
func damage_taken():
	Health -= Stats.damage
	Monster_health.max_value = Max_Health
	Monster_health.value = Health #update healthbar
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://idle.tscn")
func level_up():
	Stats.level += 1
	Stats.skill_points += 3
func monster_spawn():
	Stats.difficulty += 1
	$Difficulty.text = "Difficulty: " + str(Stats.difficulty)
	var rng = randi_range(0,10000) * (Stats.difficulty / 10) # 0 < Common < 3000, 3000 < Uncommon < 7500,7500 < Rare < 
	print(rng)

func named_spawn():
	var named_spawned = false
	var m_name = ''
	if Stats.monsters_killed in Stats.named_spawn:
		named_spawned = true
		m_name = Stats.named_spawn[Stats.monsters_killed]
		Max_Health = Stats.named_health[m_name] * Stats.difficulty/5
		Health = Max_Health
		Monster_health.max_value = Max_Health
		Monster_health.value = Health
		$Monster_name.text = m_name
		$Monster_name.modulate = Color.BLUE_VIOLET
