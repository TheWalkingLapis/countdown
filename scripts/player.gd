extends CharacterBody2D
class_name Player

@export var moveSpeed := 400.0
@export var maxHP := 3

@onready var voidSamples = $VoidSamples

var falling = false

func _ready():
	pass

func get_enemy_target_pos():
	return position

func _physics_process(_delta):
	if falling: 
		return
	var moveDir := Input.get_vector("player_left", "player_right", "player_up", "player_down").normalized()
	velocity = moveSpeed * moveDir;
	
	var _hasCollided := move_and_slide()
	
	var isOverVoid = true
	for sample in voidSamples.get_children():
		if !RefManager.stageRef.is_over_void(to_global(sample.position)):
			isOverVoid = false
			break
	falling = isOverVoid
