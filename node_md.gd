@icon("node_md.svg")

class_name NodeMD extends Node3D

@export var m_rot : Vector3

func _update_basis() -> void:
	var br_x : Basis = Basis(Vector3(1, 0, 0), Vector3(0, cosh(m_rot.x), sinh(m_rot.x)), Vector3(0, sinh(m_rot.x), cosh(m_rot.x)))
	var br_y : Basis = Basis(Vector3(cosh(m_rot.y), 0, sinh(m_rot.y)), Vector3(0, 1, 0), Vector3(sinh(m_rot.y), 0, cosh(m_rot.y)))
	var br_z : Basis = Basis(Vector3(cos(m_rot.z), -sin(m_rot.z), 0), Vector3(sin(m_rot.z), cos(m_rot.z), 0), Vector3(0, 0, 1))
	
	basis = br_z * br_y * br_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	_update_basis()
