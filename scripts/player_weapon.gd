extends CharacterBody2D
class_name PlayerWeapon

@export var moveSpeed := 400.0
# multiplier for controlled movement, else is idle speed
@export var speedMultiplier := 2.5

# track initial scale, beacuase of upscaling within stage/game
@onready var initialScale := scale

var angleDrag: = 0.75
var swordUnsheathed := false
var swordUnsheathable := false
var swordUnsheathCooldown: = 0.5
var swordSheatedScale := 0.25

func _ready():
	sheathe()

func activate_unsheate_cooldown():
	await get_tree().create_timer(swordUnsheathCooldown).timeout
	swordUnsheathable = true

func unsheathe(startDir := Vector2.RIGHT):
	if swordUnsheathable:
		swordUnsheathable = false
		swordUnsheathed = true
		scale = initialScale
		velocity = moveSpeed * startDir

func sheathe():
	scale = Vector2(swordSheatedScale, swordSheatedScale)
	swordUnsheathable = false
	swordUnsheathed = false
	velocity = Vector2.ZERO
	activate_unsheate_cooldown()

func _physics_process(_delta):
	var moveDir := Input.get_vector("weapon_left", "weapon_right", "weapon_up", "weapon_down").normalized()
	
	# sword is not unsheathed rn
	if !swordUnsheathed:
		# ... and not being unsheated (stay on player)
		if not (swordUnsheathable and moveDir != Vector2.ZERO):
			position = RefManager.playerRef.position
			return
		# ... but is unsheaded now
		unsheathe(moveDir)
	
	var currentDir := velocity.normalized()
	var speed = moveSpeed if moveDir == Vector2.ZERO else moveSpeed * speedMultiplier
	velocity = speed * lerp(moveDir, currentDir, angleDrag)
	
	move_and_slide()
	
	# rotate according to velocity vec
	if velocity != Vector2.ZERO:
		rotation = velocity.angle() + 0.5 * PI
	position = Util.modulo_position(position, get_viewport_rect())
