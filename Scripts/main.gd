extends Node
var Difficulty = Stats.Difficulty
var Damage = Stats.Damage
var Bal = Stats.Bal
var Summon_Mult = Stats.Summon_Mult
var total_copper = Stats.total_copper
var Monster_list = {'Mucus': 70,'Goblin': 120,'Orc': 200,"Ent" : 500 ,'Shade': 1000,'Fiend': 2500,'Dragon': 100000,}
var Monster_rarity = {'Mucus': 15 , 'Goblin': 40,'Orc' : 60 ,"Ent" : 100 ,'Shade': 140,'Fiend': 170,'Dragon': 250,}
var M_drops = {'Mucus': 30 , 'Goblin': 60,'Orc' : 200 ,"Ent" : 2000, 'Shade': 10000,'Fiend': 30000,'Dragon': 1500000000,}
var Max_Health = 0
var Health = 0
@onready var Monster_health = $HealthBar
@onready var Summon_time = $TimeLeft
func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	Summon_time.start(30)
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			Damage_taken()
func initialiser(): 
	$Balance.text = "Bal: " + str(Bal)
	$Damage.text = "Damage: " + str(Damage)
	$Damage.modulate = Color.GREEN_YELLOW
	$Difficulty.modulate = Color.FIREBRICK
	$Difficulty.text = "Difficulty: " + str(Difficulty)
	Monster_health.max_value = Max_Health
	Monster_health.value = Health
	Monster_spawn()
func Monster_spawn():
	Difficulty += 1
	var last_monster = $Monster_name.text
	$Difficulty.text = "Difficulty: " + str(Difficulty)
	if last_monster in M_drops: #check monster value and add it to balance
			total_copper = total_copper + (M_drops[last_monster] * Difficulty / 10)
			Bal = Money_convert() 
			$Balance.text = "Bal: " + str(Bal) #update balance
	var Monster_summoned = randi_range(1, 100) #generate a random number
	Monster_summoned += (Difficulty * 1.5) #increase chance of stronger monsters proportional to difficulty
	var m_name = ''
	for Name in Monster_list:
		if Monster_summoned >= Monster_rarity[Name]:
			if Name == last_monster: #check for repeated monster summons
				Monster_summoned = randi_range(1, 100) + (Difficulty * 2)
			else: #if not a repeated monster than execute this code
				Max_Health = Monster_list[Name] * Difficulty/5
				Health = Max_Health
				m_name = Name
				$Monster_name.text = m_name
				Monster_health.max_value = Max_Health
				Monster_health.value = Health
				if Max_Health >= Damage * 50: #set Name color based on difficulty
					$Monster_name.modulate = Color.RED
				elif Max_Health >= Damage * 15:
					$Monster_name.modulate = Color.YELLOW
				else:
					$Monster_name.modulate = Color.GREEN
func Monster_killed():
	Stats.Add_Kills()
	Monster_spawn()
func _process(_delta:float):
	if Health <= 0:
		Monster_killed()
	$SummonBar.value = (int(Summon_time.time_left) / Summon_time.wait_time) * 100
func Damage_taken():
	Health -= Damage
	Monster_health.value = Health #update healthbar
func Money_convert():
	var plat : int = total_copper / 100000000
	var gold : int = (total_copper %100000000) / 100000
	var silver : int = (total_copper% 10000) / 100
	var copper : int = total_copper % 100
	var parts = []
	if plat > 0:
		parts.append('%dp' % plat)
	if gold > 0:
		parts.append('%dg' % gold)
	if silver > 0:
		parts.append('%ds' % silver)
	parts.append("%dc" % copper)
	return ' '.join(parts)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://idle.tscn")
