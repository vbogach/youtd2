extends Control


signal expanded(expand)


onready var _tooltip_labels: Array = get_tree().get_nodes_in_group("tooltip_variable")
onready var _expand_button: Button = get_node("%ExpandButton")


#########################
###       Public      ###
#########################

func set_header_unit(tower):
	for label in _tooltip_labels:
		var stat = _get_stat(label, tower)
		label.text = str(stat)


#########################
###      Private      ###
#########################

func _get_stat(tower_stat_label: Label, tower):
	var stat_name = tower_stat_label.get_name()
	var getter_name = "get_" + Utils.camel_to_snake(stat_name)
	var stat = tower.call(getter_name)
	return stat


#########################
###     Callbacks     ###
#########################

func _on_ExpandButton_toggled(button_pressed):
	var icon_atlas: AtlasTexture = _expand_button.icon
	if button_pressed:
		icon_atlas.region.position.x = icon_atlas.region.size.x
	else:
		icon_atlas.region.position.x = 0
	emit_signal("expanded", button_pressed)