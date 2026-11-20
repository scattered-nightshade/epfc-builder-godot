class_name SkillWeb extends Control

const SKILL_WEB_BUTTON = preload("res://app/skill_web/skill_web_button.tscn")

@export var skill_web_data: SkillWebResource = preload("res://data/skill_web/skill_web.tres")
var buttons: Dictionary[int, SkillWebButton] = {}

@onready var connections: Control = %Connections

var hovered: SkillWebButton
var highlight_held: bool = false

func _ready() -> void:
	populate()
	
	Build.changed.connect(on_build_changed)
	on_build_changed()

func populate() -> void:
	for butt in buttons.values():
		butt.queue_free()
	
	buttons.clear()
	hovered = null
	
	if skill_web_data == null:
		return
	
	for node in skill_web_data.nodes:
		if node == null:
			continue
		
		var butt: SkillWebButton = SKILL_WEB_BUTTON.instantiate()
		
		butt.setup(node)
		add_child(butt)
		buttons.set(node.id, butt)
		
		butt.toggled.connect(func(state):
			Build.set_skill_allocated(node.id, state)
			butt.set_pressed_no_signal(Build.is_skill_allocated(node.id))
		)
		
		butt.mouse_entered.connect(on_button_hovered.bind(butt))
		butt.mouse_exited.connect(on_button_unhovered.bind(butt))
	
	connections.queue_redraw()

func get_button(id: int) -> SkillWebButton:
	return buttons.get(id)

func on_build_changed() -> void:
	for id in buttons:
		buttons.get(id).set_pressed_no_signal(Build.is_skill_allocated(id))
	
	connections.queue_redraw()

func _input(event: InputEvent) -> void:
	if event.is_action("highlight_similar") and !event.is_echo():
		highlight_held = event.is_pressed()
		update_highlight()

func on_button_hovered(butt: SkillWebButton) -> void:
	hovered = butt
	update_highlight()

func on_button_unhovered(butt: SkillWebButton) -> void:
	if hovered == butt:
		hovered = null
		update_highlight()

func update_highlight() -> void:
	var skill: SkillResource
	
	if highlight_held && hovered:
		skill = hovered.skill_node.skill
	else:
		skill = null
	
	for butt in buttons.values():
		butt.similar_highlight = skill != null && butt.skill_node.skill == skill
