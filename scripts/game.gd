extends Node2D
class_name Game

@onready var player := $Player
@onready var playerWeapon := $PlayerWeapon
@onready var currentStageParent := $CurrentStage

@export var stages: Array[PackedScene]

var currentStage: Stage = null
var currentStageIdx = 0

func _ready():
	RefManager.gameRef = self
	RefManager.playerRef = get_node("Player")
	
	playerWeapon.enemy_hit.connect(_on_playerWeapon_hits_enemy)
	
	select_stage(currentStageIdx)

func select_stage(idx):
	if currentStage != null:
		currentStageParent.remove_child(currentStage)
		currentStage.queue_free()
	
	var stage = stages[idx].instantiate()
	currentStageParent.add_child(stage)
	
	currentStage = stage
	currentStage.all_enemies_defeated.connect(stage_cleared)
	RefManager.stageRef = currentStage

func restart():
	get_tree().reload_current_scene.call_deferred()

func stage_cleared():
	print("WON")
	restart()

func _on_playerWeapon_hits_enemy(enemy: Enemy):
	if enemy.number == currentStage.nextNumber:
		enemy.die()
		currentStage.next_enemy()
	else:
		restart()
	
