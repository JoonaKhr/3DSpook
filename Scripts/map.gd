extends Node3D

@onready var top_fans = get_node("top_floor/turbine_sounds")
@onready var ground_fans = get_node("ground_floor/turbine_sounds")
@onready var basement_fans = get_node("basement/turbine_sounds")
@onready var player_node = get_node("Player")

#var floor: int = 1

func _ready():
	_floor_change(player_node,1)

func _on_exit_teleport_body_entered(body:Node3D):
	if body.is_in_group("player"):
		body.global_position.z = $exit_teleport/teleport.global_position.z

func _floor_change(body:Node3D,floor_nr):

	if body.name == "Player":
		top_fans.process_mode = Node.PROCESS_MODE_DISABLED
		ground_fans.process_mode = Node.PROCESS_MODE_DISABLED
		basement_fans.process_mode = Node.PROCESS_MODE_DISABLED
		
		match floor_nr:
			0:
				top_fans.process_mode = Node.PROCESS_MODE_INHERIT
			1:
				ground_fans.process_mode = Node.PROCESS_MODE_INHERIT
			2:
				basement_fans.process_mode = Node.PROCESS_MODE_INHERIT