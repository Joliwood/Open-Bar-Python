extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Reset horizontal velocity at the start of each physics frame
	velocity.x = 0
	velocity.z = 0

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = -1  # A slight negative Y to keep character grounded

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement input checks
	var is_moving = false

	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
		is_moving = true
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		is_moving = true
	if Input.is_action_pressed("ui_up"):
		velocity.z -= SPEED  # Assuming forward/back movement is along the Z axis
		is_moving = true
	if Input.is_action_pressed("ui_down"):
		velocity.z += SPEED
		is_moving = true

	# Animation state updates
	$barman_v3/anim.set("parameters/conditions/walk", is_moving)
	$barman_v3/anim.set("parameters/conditions/stand", !is_moving)

	move_and_slide()
