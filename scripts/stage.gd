extends Node2D
class_name Stage

@onready var tileMapLayer := $TileMapLayer
	
func is_over_void(pos) -> bool:
	var cell = tileMapLayer.local_to_map(pos / tileMapLayer.scale)
	var data = tileMapLayer.get_cell_tile_data(cell)
	if data:
		return data.get_custom_data("isVoid")
	else:
		return false
