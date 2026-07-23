extends CharacterBody2D
class_name Player

@export var moveSpeed := 400.0
@export var maxHP := 3

func _ready():
	pass

func get_enemy_target_pos():
	return position

func _physics_process(_delta):
	var moveDir := Input.get_vector("player_left", "player_right", "player_up", "player_down").normalized()
	velocity = moveSpeed * moveDir;
	
	var hasCollided := move_and_slide()
