@tool
@icon("icontroller.svg")
class_name Controller
## Base class for all Controllers.
## A Controller must only be used to gather inputs, whether they are from a Player or an AI.
## To interact with its [member pawn], the controller must write and read the [member context].
extends Node

signal pawn_posessed(pawn : Node)
signal pawn_unposessed(pawn : Node)

## [Pawn2D] or [Pawn3D] controlled by the Controller.
@export var pawn : Node :
	set(new_pawn):
		if(new_pawn is Pawn2D == false and new_pawn is Pawn3D == false and new_pawn != null): 
			push_warning("pawn must be Pawn2D or Pawn3D, not setting new pawn")
			return
		pawn = new_pawn
		
## Associated [ControlContext].
## The [ControlContext] acts as a shared resource of values where the Controller modifies them and the [Pawn] reads them to add functionality.
@export var control_context : ControlContext
	
	
func _ready() -> void:
	if(pawn != null):
		posess(pawn)
	
## Assigns a pawn to interact with.
func posess(pawn : Variant) -> void:
	if(!pawn.is_available()): return
	if(pawn != null):
		pawn.free_control()
	pawn.set_control(self)
	self.pawn = pawn
	pawn_posessed.emit(pawn)
	
## Liberates pawn.
func unposess() -> void:
	if(pawn == null):
		return
	pawn.free_control()
	pawn_posessed.emit(pawn)
	pawn = null
	
## Virtual function, called on ready.
## Override to add your behaviour.
func ready() -> void:
	pass
	
## Virtual function, called on the associated [member pawn].
## Override to add your behaviour.
func input(event: InputEvent) -> void:
	pass
	
## Virtual function, called on the associated [member pawn].
## Override to add your behaviour.
func process(delta : float) -> void:
	pass
	
## Virtual function, called on the associated [member pawn].
## Override to add your behaviour.
func physics_process(delta : float) -> void:
	pass
