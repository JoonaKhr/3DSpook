extends CharacterBody3D

@export var SPEED = 5.0
const JUMP_VELOCITY = 4.5
const RAY_LENGTH = 5
var rot_x = 0
var rot_y = 0
var inventory

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory = $inventory

func _input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			inventory.changeHeldItem(event.button_index)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			inventory.changeHeldItem(event.button_index)
				
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * 0.002)
		$Pivot.rotate_x(-event.relative.y * 0.002)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

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
			if get_tree().get_nodes_in_group("lightswitches").has(result["collider"]):
				result["collider"].press.emit()
			#print(result)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#print(velocity)
	move_and_slide()
