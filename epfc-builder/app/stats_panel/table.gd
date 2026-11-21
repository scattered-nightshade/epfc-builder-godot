class_name StatsPanelTable extends MarginContainer

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var grid_container: GridContainer = $PanelContainer/MarginContainer/VBoxContainer/GridContainer

func _ready():
	label.gui_input.connect(on_title_clicked)

func on_title_clicked(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		grid_container.visible = !grid_container.visible
