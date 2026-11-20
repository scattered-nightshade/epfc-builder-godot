@tool class_name CombatNodeResource extends SkillNodeResource

@export var tier: int = 1
@export var mutual_exclusivity: Array[int] = []

func refresh_name() -> void:
	resource_name = "%d %s (Tier %d)" % [id, get_display_name(), tier]
