# Aqueous Vapor
extends Item


func get_extra_tooltip_text() -> String:
	var text: String = ""

	text += "[color=GOLD]Piercing Magic[/color]\n"
	text += "Deals an additional 25% damage as spell damage against creeps with Myt armor."

	return text


func load_triggers(triggers: BuffType):
	triggers.add_event_on_damage(on_damage)


func on_damage(event: Event):
	var itm: Item = self
	var T: Creep = event.get_target()
	var U: Tower = itm.get_carrier()

	if T.get_armor_type() == ArmorType.enm.MYT:
		event.damage = event.damage * 1.25
		SFX.sfx_on_unit("CrushingWaveDamage.mdl", T, "chest")