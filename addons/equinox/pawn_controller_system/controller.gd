@tool
@icon("icontroller.svg")
class_name Controller
## Base class for all Controllers.
## A Controller must only be used to gather inputs, whether they are from a Player or an AI.
## To interact with its [member pawn], the controller must write and read the [member context].
extends Node

## [Pawn] controlled by the Controller.
@export var pawn : Node :
	set(new_pawn):
		if(new_pawn is Pawn2D == false and new_pawn is Pawn3D == false): 
			push_warning("pawn must be Pawn2D or Pawn3D, not setting new pawn")
			return
		pawn = new_pawn

## Associated [ControlContext].
## The [ControlContext] acts as a shared resource of values where the Controller modifies them and the [Pawn] reads them to add functionality.
## Must be set in every class that inherits Controller, inside the method [method _init].
var context : ControlContext

func _init() -> void:
	context = ControlContext.new()
	
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
	
## Liberates pawn.
func unposess() -> void:
	pawn.free_control()
	pawn = null
	
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
