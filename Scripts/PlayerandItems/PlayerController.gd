extends CharacterBody3D


@onready var head = get_node("%head")
@onready var viewmodel = get_node("%viewmodel")

@export var SPEED = 5.0
@export var sprintMult = 1.5
const JUMP_VELOCITY = 3.5
var ray_length = 5
var rot_x = 0
var rot_y = 0
var inventory
var input_dir = Vector3(0, 0, 0)
var jumped

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory = $inventory

func _unhandled_input(event):	
	input_dir = Input.get_vector("left", "right", "forwards", "backwards")

# Capture mouse wheel scrolling for inventory
	if Input.is_action_just_pressed("showmouse"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			inventory.change_held_item(event.button_index)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			inventory.change_held_item(event.button_index)
# Capture mouse motion for camera
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * 0.002)
		$Pivot.rotate_x(-event.relative.y * 0.002)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.5, 1.5)
	
	if Input.is_action_just_pressed("toggle_flashlight"):
		if %flashlight.visible:
			%flashlight.visible = false
		else:
			%flashlight.visible = true
	elif Input.is_action_just_pressed("showmouse") and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Raycasting code for interacting with the environment
func raycastFromMouse(r_length):
	var space_state = get_world_3d().get_direct_space_state()
	var cam = $Pivot/head
	var mousepos = get_viewport().get_mouse_position()
	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * r_length
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	return space_state.intersect_ray(query)

func _process(_delta):
	viewmodel.set_global_transform(head.get_global_transform())

func _physics_process(delta):
	#play step sound upon landing from a jump
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.get_collider().name == "ground_floor" and jumped: #has some peculiarities
			$step_sound.play()
			jumped = false

	if Input.is_action_just_pressed("mouse_left"):
		var usedItem = inventory.get_current_item()
		var result
		# if is gun
		if  usedItem != null and get_tree().get_nodes_in_group("gun").has(usedItem):
			ray_length = 150
			result = raycastFromMouse(ray_length)
			usedItem.shoot(result)
			#start ammo charging if not charging
			if $ammo_charge.time_left == 0:
				$ammo_charge.start()
		ray_length = 2
		result = raycastFromMouse(ray_length)
		if result:
			if inventory.get_current_item() != null:
				inventory.get_current_item().useItem(result["collider"])
			if result["collider"].has_signal("press"):
				result["collider"].press.emit()
			#print(result["collider"])
	# use item without shooting gun		
	if Input.is_action_just_pressed("use"):
		var result
		ray_length = 2
		result = raycastFromMouse(ray_length)
		if result:
			if inventory.get_current_item() != null:
				inventory.get_current_item().useItem(result["collider"])
			if result["collider"].has_signal("press"):
				result["collider"].press.emit()

# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		#stop walking sounds when in air
		$sprint.stop()
		$steps.stop()
		#$step_sound.playing = false

# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumped = true


# Get the input direction and handle the movement/deceleration.
	
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

# Handle walking sounds
	if is_on_floor(): 
		if velocity.x or velocity.z != 0:
			if $steps.time_left == 0 and $sprint.time_left == 0:
				if sprintMult == 1.5:
					$sprint.start()
				elif sprintMult == 1:
					$steps.start()
		else:
			$steps.stop()
			$sprint.stop()
	move_and_slide()

# Charge the gun
func _on_ammo_charge_timeout():
	if Player.vars["ammo"] <= 3:
		Player.vars["ammo"] += 1
	if Player.vars["ammo"] > 3:
		$ammo_charge.stop()

func _on_steps_timeout():
	$step_sound.play()
