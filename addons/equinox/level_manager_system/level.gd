@icon("ilevel.svg")
class_name Level
## Base class for all Level classes.
## To make a Level, insert the Level node as the root of a scene;
## then right-click the node, select "Extend script...", use the "Level base template".
## A Level must be used to wire nodes together and add logic, similar to Level Blueprints in Unreal Engine. 
extends Node

## Virtual function.
## Override to add your behaviour.
func ready() -> void:
	pass

func _ready() -> void:
	if(LevelManager.level != null):
		push_warning("LevelManager.level is already set.")
		return
		
	LevelManager.level = self
	tree_exiting.connect(Callable(func() -> void:
		LevelManager.level = null
	))
	ready()
