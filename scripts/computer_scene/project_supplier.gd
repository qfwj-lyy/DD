extends Resource
class_name ProjectSupplier

enum ProjectLevel{
	LOW,
	MID,
	HIGH
}
@export var project_level : ProjectLevel
@export var projects : Array[Project]
@export var description : String
