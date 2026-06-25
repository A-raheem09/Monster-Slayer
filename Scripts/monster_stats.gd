extends Resource
class_name MStats
@export var max_health : int
@export var drops : Dictionary
@export var experience_dropped : int
@export var rarity : spawn_rarity
@export var named : bool
enum spawn_rarity{
	Common,
	Uncommon,
	Rare,
	Epic,
	Legends,
	Mythical,
}
