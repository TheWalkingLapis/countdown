extends CharacterBody2D
class_name PlayerWeapon

@export var moveSpeed := 600.0

func _ready():
	pass

func _physics_process(_delta):
	var moveDir := Input.get_vector("weapon_left", "weapon_right", "weapon_up", "weapon_down").normalized()
	velocity = moveSpeed * moveDir;
	
	move_and_slide()
