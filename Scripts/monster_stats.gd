extends Resource
class_name MStats
@export var max_health : int
@export var name : String
@export var drops :Array
@export var experience_dropped : int
@export var rarity : spawn_rarity
@export var named : bool
enum spawn_rarity{
	Common,
	Rare,
	Legends,
	Mythical,
}
func common_drops():
	var roll:int = randi_range(1, 100)  * Save.stats['luck'] #number scales with luck
	if roll > 35 and roll < 50: #35% chance to get nothing, 15% chance to get a drop , 1% chance to get the rare drop
		Save.inventory.append(drops[0])
	if roll >= 99:
		Save.inventory.append(drops[1])
