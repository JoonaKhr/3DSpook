extends Node


func _ready():
    call_deferred("custom_setup")

func custom_setup():
    var map: RID = NavigationServer3D.get_maps()[0]
    NavigationServer3D.map_set_up(map, Vector3.UP)
    NavigationServer3D.map_set_cell_height(map, 0.01)
    NavigationServer3D.map_set_active(map, true)

    var region: RID = NavigationServer3D.region_create()
    NavigationServer3D.region_set_transform(region, Transform3D())
    NavigationServer3D.region_set_map(region, map)

    var new_navigation_mesh: NavigationMesh = NavigationMesh.new()
    var vertices: PackedVector3Array = PackedVector3Array([
        Vector3(0,0,0),
        Vector3(9.0, 0, 0),
        Vector3(0,0,9.0)
    ])
    new_navigation_mesh.set_vertices(vertices)
    var polygon: PackedInt32Array = PackedInt32Array([0, 1, 2])
    new_navigation_mesh.add_polygon(polygon)
    NavigationServer3D.region_set_navigation_mesh(region, new_navigation_mesh)
    
    await get_tree().physics_frame

    var start_position: Vector3 = Vector3(0.1, 0.0, 0.1)
    var target_position: Vector3 = Vector3(1.0, 0.0, 1.0)
    var optimize_path: bool = true

    var path: PackedVector3Array = NavigationServer3D.map_get_path(
        map, 
        start_position, 
        target_position, 
        optimize_path
    )
    print("Found")
    print(path)
