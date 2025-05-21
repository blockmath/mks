class_name RigidBodyMD extends NodeMD

@export var velocity : Vector3 = Vector3.ZERO

const GRAVITY_SCALE : float = 9.8

func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	if $Area3D.has_overlapping_areas():
		velocity = Vector3.ZERO
	else:
		velocity += Vector3.DOWN * delta * GRAVITY_SCALE
		velocity *= pow(0.5, delta)
	position += velocity * delta
