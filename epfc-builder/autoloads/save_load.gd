extends Node

const SAVE_PATH: String = "user://build.cfg"
const SECTION: String = "BUILD"

var save_queued: bool = false

func _ready() -> void:
	load_build()
	Build.changed.connect(on_build_changed)

func on_build_changed() -> void:
	if save_queued:
		return
	
	save_queued = true
	save_build.call_deferred()
	
func save_build() -> void:
	save_queued = false
	
	var conf_file: ConfigFile = ConfigFile.new()
	conf_file.set_value(SECTION, "SKILLS", Build.get_allocated_skill_ids())
	conf_file.set_value(SECTION, "COMBAT_PERKS", Build.get_allocated_perk_ids())
	conf_file.set_value(SECTION, "LEVEL", Build.get_level())
	
	var err: Error  = conf_file.save(SAVE_PATH)
	if err != OK:
		push_warning("Couldn't save build to %s (error %d)" % [SAVE_PATH, err])

func load_build() -> void:
	var conf_file: ConfigFile = ConfigFile.new()
	if conf_file.load(SAVE_PATH) != OK:
		return
	
	Build.apply_build(
		conf_file.get_value(SECTION, "SKILLS", []),
		conf_file.get_value(SECTION, "COMBAT_PERKS", []),
		conf_file.get_value(SECTION, "LEVEL", Build.get_level()),
	)
