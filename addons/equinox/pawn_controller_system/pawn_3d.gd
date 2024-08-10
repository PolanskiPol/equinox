@icon("ipawn_3d.svg")
class_name Pawn3D
## Base class for all 3D Pawns.
## A Pawn is a [Node3D] that can be controlled by either a player or AI. 
## A pawn must never take input, it must only process the [ControlContext], act according to its values, and sometimes write in it to communicate with the [Controller].
## All 3D Pawns must extend from this base class.
extends Node3D

## Associated [ControlContext]
## The [ControlContext] acts as a shared resource of values where the [Controller] modifies them and the Pawn reads them to add functionality.
var context : ControlContext

## Associated [Controller].
## The [Controller] is in charge of reading and handling inputs for the Pawn to react.
var _controller : Controller

func set_control(controller : Controller):
	if(_controller != null): return
	_controller = controller
	context = controller.context
	
func free_control() -> void:
	_controller = null
	context = null
	
## Virtual function. Called on input.
## Override to add your behaviour.
func input(event: InputEvent) -> void:
	pass
	
## Virtual function. Called every frame.
## Override to add your behaviour.
func process(delta : float) -> void:
	pass
	
## Virtual function. Called every physics frame.
## Override to add your behaviour.
func physics_process(delta : float) -> void:
	pass
	
## If it has no [member _controller] set, the Pawn is available.
func is_available() -> bool:
	return _controller == null
	
func _input(event: InputEvent) -> void:
	if(_controller != null):
		_controller.input(event)
	input(event)
	
func _process(delta: float) -> void:
	if(_controller != null):
		_controller.process(delta)
	process(delta)
	
func _physics_process(delta: float) -> void:
	if(_controller != null):
		_controller.physics_process(delta)
	physics_process(delta)
