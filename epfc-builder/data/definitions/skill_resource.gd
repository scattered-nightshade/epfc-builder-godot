@tool class_name SkillResource extends Resource

@export var id: StringName = ""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var major_skill: bool = false

@export var unselected_icon: Texture2D
@export var selected_icon: Texture2D
@export var similar_icon: Texture2D
