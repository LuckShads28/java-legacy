extends Node2D
	
@export var id_cerita : int = 0
@export_file("*.json") var cerita_wayang_json = "res://Assets/cerita_wayang.json"
var data_cerita = {}
var cerita

func _ready():
	data_cerita = loadCerita(cerita_wayang_json)
	cerita = data_cerita.get(str(id_cerita))
	print(cerita)

func loadCerita(filepath: String):
	if FileAccess.file_exists(cerita_wayang_json):
		var dataFile = FileAccess.open(cerita_wayang_json, FileAccess.READ)
		var parseResult = JSON.parse_string(dataFile.get_as_text())
		
		if parseResult is Dictionary:
			return parseResult
		else:
			print("Error read data")

func _on_area_2d_body_entered(_body):
	queue_free()
