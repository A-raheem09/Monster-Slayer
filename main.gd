extends Node
var Difficulty = 0
var Damage = 10
var Max_Health = 0
var Health = 0
var Bal = 0
var total_copper = 0
var Monster_list = {'Mucus': 70,'Goblin': 120,'Orc': 300, 'Shade': 700,'Fiend': 2500,'Dragon': 100000,}
var Monster_rarity = {'Mucus': 15 , 'Goblin': 40, 'Orc' : 80 , 'Shade': 110,'Fiend': 130,'Dragon': 150,}
var M_drops = {'Mucus': 30 , 'Goblin': 60, 'Orc' : 500 , 'Shade': 10000,'Fiend': 300000,'Dragon': 1500000000,}
@onready var style_box = StyleBoxFlat.new()
@onready var Monster_health = $Health_bar
@onready var Spawn_Time = $"Spawn Time"
func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			Damage_taken()
	if $MenuButton.button_pressed == true:
		$MenuButton.show_popup()
func initialiser(): 
	$Balance.text = "Bal: " + str(Bal)
	$Health.text = "Health: "  #initialise all variables onto the screen
	$Health.modulate = Color.WHITE
	$Damage.text = "Damage: " + str(Damage)
	$Damage.modulate = Color.FIREBRICK
	$Difficulty.modulate = Color.GREEN_YELLOW
	$Difficulty.text = "Difficulty: " + str(Difficulty)
	Monster_health.max_value = Max_Health
	Monster_health.value = Health
	style_box.bg_color = Color(0.0,1.0,0.0) #healthbar of the monster
	Monster_health.add_theme_stylebox_override("fill", style_box)
	style_box.corner_radius_top_left = 20
	style_box.corner_radius_top_right = 20
	style_box.corner_radius_bottom_right = 20
	style_box.corner_radius_bottom_left = 20
	$MenuButton.get_popup().add_item("My Item Name")
	Monster_spawn()
func Monster_spawn():
	Difficulty += 1
	var last_monster = $Monster_name.text
	$Difficulty.text = "Difficulty: " + str(Difficulty)
	if last_monster in M_drops:
			total_copper = total_copper + (M_drops[last_monster] * Difficulty / 10)
			Bal = Money_convert()
			$Balance.text = "Bal: " + str(Bal)
	var Monster_summoned = randi_range(1, 100)
	Monster_summoned += (Difficulty * 2)
	var m_name = ''
	for Name in Monster_list:
		if Monster_summoned >= Monster_rarity[Name]:
			if Name == last_monster:
				Monster_summoned = randi_range(1, 100) + (Difficulty * 2)
			else:
				Max_Health = Monster_list[Name] * Difficulty/5
				Health = Max_Health
				m_name = Name
				$Monster_name.text = m_name
				Monster_health.max_value = Max_Health
				Monster_health.value = Health
				if Max_Health >= Damage * 50:
					$Monster_name.modulate = Color.RED
				elif Max_Health >= Damage * 15:
					$Monster_name.modulate = Color.YELLOW
				else:
					$Monster_name.modulate = Color.GREEN
				style_box.bg_color = Color(0.0,1.0,0.0)
				Monster_health.add_theme_stylebox_override("fill", style_box)
func Monster_killed():
	Spawn_Time.timeout.connect(Monster_spawn)
	Spawn_Time.autostart = true
	$Monster_name.modulate = Color.DARK_GREEN
	Spawn_Time.start(2.0)
	$Monster_name.text = 'Searching For Monsters'
	await Spawn_Time.timeout
func _process(_delta:float):
	if Health <= 0:
		Monster_killed()
	var health_percent = float(Health) / Max_Health
	if health_percent > 0.5:#adds color to the health bar
		style_box.bg_color = Color(0.0,1.0,0.0)
		Monster_health.add_theme_stylebox_override("fill", style_box)
	elif health_percent > 0.25:
		style_box.bg_color = Color(1.0,1.0,0.0)
		Monster_health.add_theme_stylebox_override("fill", style_box)
	elif health_percent < 0.25:
		style_box.bg_color = Color(1.0,0.0,0.0)
		Monster_health.add_theme_stylebox_override("fill", style_box)
	if Max_Health >= Damage * 50: #difficulty of the monster
		$Monster_name.modulate = Color.RED
	elif Max_Health >= Damage * 15:
		$Monster_name.modulate = Color.YELLOW
	elif Max_Health <= Damage * 5:
		$Monster_name.modulate = Color.GREEN
func Damage_taken():
	Health -= Damage
	Monster_health.value = Health
	var health_percent = float(Health) / Max_Health
	if health_percent > 0.5:
		style_box.bg_color = Color(0.0,1.0,0.0)
		Monster_health.add_theme_stylebox_override("fill", style_box)
	elif health_percent > 0.25:
		style_box.bg_color = Color(1.0,1.0,0.0)
		Monster_health.add_theme_stylebox_override("fill", style_box)
	else:
		style_box.bg_color = Color(1.0,0.0,0.0)
		Monster_health.add_theme_stylebox_override("fill", style_box)
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
