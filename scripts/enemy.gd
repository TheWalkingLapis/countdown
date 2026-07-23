extends CharacterBody2D
class_name Enemy

@export var moveSpeed := 200.0

@onready var navAgent: NavigationAgent2D = $NavigationAgent2D
@onready var label := $Label

var number = -1:
	set(num):
		label.text = str(num)
		number = num

func _physics_process(_delta):
	var targetPos = RefManager.playerRef.get_enemy_target_pos()
	if !targetPos:
		velocity = Vector2.ZERO
		return
	navAgent.target_position = targetPos
	
	if navAgent.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var nextPos = navAgent.get_next_path_position()

	var direction = global_position.direction_to(nextPos)

	velocity = direction * moveSpeed
	move_and_slide()

func die():
	queue_free()
