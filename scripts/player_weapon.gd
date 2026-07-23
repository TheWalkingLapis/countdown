extends CharacterBody2D
class_name PlayerWeapon

@export var moveSpeed := 400.0
# multiplier for controlled movement, else is idle speed
@export var speedMultiplier := 2.5

var angleDrag = 0.75

func _ready():
	pass

func _physics_process(_delta):
	var moveDir := Input.get_vector("weapon_left", "weapon_right", "weapon_up", "weapon_down").normalized()
	
	var currentDir := velocity.normalized()
	var speed = moveSpeed if moveDir == Vector2.ZERO else moveSpeed * speedMultiplier
	velocity = speed * lerp(moveDir, currentDir, angleDrag)
	
	move_and_slide()
	
	# rotate according to velocity vec
	if velocity != Vector2.ZERO:
		rotation = velocity.angle() + 0.5 * PI
	position = Util.modulo_position(position, get_viewport_rect())
