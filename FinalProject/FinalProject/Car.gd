extends RigidBody3D

func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("ui_left","ui_right")
	input.z = Input.get_axis("ui_up","brake")
	
	apply_central_force(input * 12000.0 * delta)

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var steering = 0.0
var engineforce = 0.0

@warning_ignore("unused_parameter")
func _physics_process(delta):
	steering = Input.get_axis("ui_left","ui_right") *.1000
	engineforce = Input.get_axis("ui_up","brake") *.1000
	# Add the gravity.

	# Handle Jump.
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	@warning_ignore("unused_variable")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	

	

		
