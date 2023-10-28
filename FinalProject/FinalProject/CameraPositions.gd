extends Marker3D

var target_object : MeshInstance3D  # Reference to the Quad Sphere object
var follow_speed = 5.0  # Adjust the follow speed as needed

func _ready():
	# Find the Quad Sphere object by name
	target_object = $"../../QuadSphere"

func _process(_delta):
	if target_object:
		# Calculate the new camera position by interpolating between the current camera position and the target object's position
		var new_position = lerp(transform.origin, target_object.transform.origin, follow_speed * get_process_delta_time())

		# Set the camera's new position
		transform.origin = new_position

func _input(event):
	if event.is_action_pressed("switch_camera_view"):
		# Handle camera view change here
		# You can switch between different camera positions
		set_camera_position("AnotherCameraPosition")

func set_camera_position(position_name):
	var camera_positions = $CameraPositions

	if camera_positions.has_node(position_name):
		var camera_position = camera_positions.get_node(position_name)
		transform.origin = camera_position.transform.origin
