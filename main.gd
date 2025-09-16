extends Node
var Difficulty = 1
var Damage = 100
var Max_Health = 0
var Health = 0
var Monster_list = {'Mucus': 70,'Goblin': 100,'Orc': 200, 'Shade': 1000,'Martin': 20000,'Dragon': 99999,}
var Monster_rarity = {'Mucus': 20 , 'Goblin': 40, 'Orc' : 70 , 'Shade': 95,'Martin': 110,'Dragon': 150,}
@onready var style_box = StyleBoxFlat.new()
@onready var Monster_health = $Health_bar


func _ready(): #called when the player enters the scene tree for the first time
	initialiser()
	
func _input(event):
	if event.is_action_pressed("Attack"):
		if Health > 0:
			Damage_taken()
func initialiser():
	Monster_spawn()
	$Health.text = "Health: "  #initialise all variables onto the screen
	$Health.modulate = Color.WHITE
	$Damage.text = "Damage: " + str(Damage)
	$Damage.modulate = Color.DARK_ORANGE
	$Difficulty.modulate = Color.GREEN_YELLOW
	$Difficulty.text = "Difficulty: " + str(Difficulty)
	Monster_health.max_value = Max_Health
	Monster_health.value = Health
	$Timer.timeout.connect(Monster_status) #timer for checking monster status
	$Timer.one_shot = false
	$Timer.start(0.75)
	style_box.bg_color = Color(0.0,1.0,0.0) #healthbar of the monster
	Monster_health.add_theme_stylebox_override("fill", style_box)
	style_box.corner_radius_top_left = 20
	style_box.corner_radius_top_right = 20
	style_box.corner_radius_bottom_right = 20
	style_box.corner_radius_bottom_left = 20
	Monster_spawn()
func Monster_spawn():
	var Monster_summoned = randi_range(1, 100)
	Monster_summoned += (Difficulty * 2)
	var m_name = ''
	for key in Monster_list:
		if Monster_summoned >= Monster_rarity[key]:
			Max_Health = Monster_list[key] * Difficulty/5
			Health = Max_Health
			m_name = key
			$Monster_name.text = m_name   
	Monster_health.max_value = Max_Health
	Monster_health.value = Health
	if Max_Health >= Damage * 50:
		$Monster_name.modulate = Color.RED
	elif Max_Health >= Damage * 15:
		$Monster_name.modulate = Color.YELLOW
	elif Max_Health <= Damage * 5:
		$Monster_name.modulate = Color.GREEN
	style_box.bg_color = Color(0.0,1.0,0.0)
	Monster_health.add_theme_stylebox_override("fill", style_box)
	
func Monster_killed():
	Difficulty += 1
	$Difficulty.text = "Difficulty: " + str(Difficulty)
	Monster_spawn()
func Monster_status():
		var health_percent = float(Health) / Max_Health
		if Health <= 0:
			Monster_killed()
		elif health_percent > 0.5:
			style_box.bg_color = Color(0.0,1.0,0.0)
			Monster_health.add_theme_stylebox_override("fill", style_box)
		elif health_percent > 0.25:
			style_box.bg_color = Color(1.0,1.0,0.0)
			Monster_health.add_theme_stylebox_override("fill", style_box)
		elif health_percent < 0.25:
			style_box.bg_color = Color(1.0,0.0,0.0)
			Monster_health.add_theme_stylebox_override("fill", style_box)
		if Max_Health >= Damage * 50:
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
