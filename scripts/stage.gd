extends Node2D
class_name Stage

signal all_enemies_defeated()

@export var enemyScenes: Array[PackedScene]

@onready var tileMapLayer := $TileMapLayer
@onready var enemyParent := $Enemies

var nextNumber = 1

func _ready():
	for enemyScene in enemyScenes:
		var enemy: Enemy = enemyScene.instantiate()
		enemy.position = get_viewport_rect().size * 0.75
		enemyParent.add_child(enemy)
		
		enemy.number = nextNumber
		nextNumber += 1
	nextNumber -= 1

func next_enemy():
	nextNumber -= 1
	if nextNumber <= 0:
		all_enemies_defeated.emit()

func is_over_void(pos) -> bool:
	var cell = tileMapLayer.local_to_map(pos / tileMapLayer.scale)
	var data = tileMapLayer.get_cell_tile_data(cell)
	if data:
		return data.get_custom_data("isVoid")
	else:
		return false
