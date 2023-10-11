extends CharacterBody3D

var speed = 2
var accel = 10
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var nav: NavigationAgent3D = $NavigationAgent3D


func _ready():
	nav.path_desired_distance = 0.5
	nav.target_desired_distance = 0.5
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(get_parent().get_node("target").global_position)

func set_movement_target(movement_target: Vector3):
	nav.set_target_position(movement_target)

func _physics_process(delta):
	if nav.is_navigation_finished():
		return
	
	var curr_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = nav.get_next_path_position()

	var new_velocity: Vector3 = next_path_position - curr_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * speed
	if not is_on_floor():
		velocity.y -= gravity * delta

	velocity = new_velocity

	move_and_slide()
