@tool class_name SkillNodeResource extends Resource

@export var id: int = 0
@export var skill: SkillResource
@export var position: Vector2 = Vector2.ZERO
@export var core: bool = false
@export var player_class: Array[PlayerClass.CLASS_NAMES] = []
@export var connections: Array[int] = []

func get_display_name() -> String:
	if skill:
		return skill.display_name
	else:
		return "N/A"

func get_description() -> String:
	if skill:
		return skill.description
	else:
		return "N/A"

func refresh_name() -> void:
	resource_name = "%d %s" % [id, get_display_name()]
