extends CharacterBody3D

@export var SPEED = 5.0
@export var sprintMult = 1.5
const JUMP_VELOCITY = 3.5
const RAY_LENGTH = 5
var rot_x = 0
var rot_y = 0
var inventory

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory = $inventory

func _input(event):
# Capture mouse wheel scrolling for inventory
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			inventory.changeHeldItem(event.button_index)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			inventory.changeHeldItem(event.button_index)
# Capture mouse motion for camera
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * 0.002)
		$Pivot.rotate_x(-event.relative.y * 0.002)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
	
	if Input.is_action_just_pressed("toggle_flashlight"):
		if %flashlight.visible:
			%flashlight.visible = false
		else:
			%flashlight.visible = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Raycasting code for interacting with the environment
func raycastFromMouse():
	var space_state = get_world_3d().direct_space_state
	var cam = $Pivot/Camera3D
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	return space_state.intersect_ray(query)

func _physics_process(delta):
	var result = raycastFromMouse()
	if Input.is_action_just_pressed("mouse_left"):
		if result:
			if inventory.itemDict[inventory.heldItem] != null:
				inventory.itemDict[inventory.heldItem].useItem(result["collider"])
			if get_tree().get_nodes_in_group("lightswitches").has(result["collider"]):
				result["collider"].press.emit()
			if get_tree().get_nodes_in_group("pickupables").has(result["collider"]):
				result["collider"].press.emit()
			if get_tree().get_nodes_in_group("doorswitches").has(result["collider"]):
				result["collider"].press.emit()
			print(result["collider"])
# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
# Get the forward direction from the character node
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

# Change the movement multiplier for a sprint
	if Input.is_action_pressed("sprint"):
		sprintMult = 1.5
	else:
		sprintMult = 1
	if direction:
# Move the character
		velocity.x = direction.x * SPEED * sprintMult
		velocity.z = direction.z * SPEED * sprintMult
	else:
# Stop the character
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
