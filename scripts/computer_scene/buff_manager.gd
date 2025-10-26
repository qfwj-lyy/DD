extends Control

@onready var once: Node = $Once
@onready var each_time: Node = $EachTime
@onready var each_round_begin: Node = $EachRoundBegin
@onready var each_round_over: Node = $EachRoundOver
@onready var each_project_delivery: Node = $EachProjectDelivery



func get_all_buffs() -> Array[Buff]:
	var buffs : Array[Buff]
	for buff_type in get_children():
		for buff : Buff in buff_type.get_children():
			buffs.append(buff)
	return buffs

func buff_name_to_buff(buff_name : String) -> Buff:
	var bs = get_all_buffs()
	for b in bs:
		if b.name == buff_name:
			return b
	return null


@export var buff_icon: Node
@export var buff_icons: Node
var buff_and_icon_list := []
func add_buff_icon(node: Node):
	if node is Buff:
		var icon_node = buff_icon.duplicate()
		icon_node.set_description(node.description)
		buff_icons.add_child(icon_node)
		var buff_and_icon = [node, icon_node]
		buff_and_icon_list.append(buff_and_icon)
func erase_buff_icon(node: Node):
	if node is Buff:
		for BAI in buff_and_icon_list:
			if BAI[0] == node:
				BAI[1].queue_free()
				break
		printerr("error in BuffManager _on_child_ex")
