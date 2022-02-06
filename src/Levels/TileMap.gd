extends TileMap

var usedX = []

var buildingSelection = "library"

var toggleGuide = true

func _ready() -> void:
	$backgroundMusic.play()

#checks to see if player changes which type of building they want to place
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("library"):
		$switchSound.play()
		buildingSelection = "library"
	elif Input.is_action_just_pressed("frank"):
		$switchSound.play()
		buildingSelection = "frank"
	elif Input.is_action_just_pressed("statue"):
		$switchSound.play()
		buildingSelection = "statue"
	var playerPosition = $Player.get_position()
	playerPosition[0] += 64
	
	#test function to put library silloute over would be spot
	if toggleGuide == true:
		var tilePosition = world_to_map(playerPosition)
		if buildingSelection == "library":
			get_node("frankFrame").visible = false
			get_node("libraryFrame").visible = true
			get_node("statueFrame").visible = false
			#checks to see if theres any active tiles and tiles have been previously used
			if get_cell(tilePosition[0],7) == -1 && get_cell(tilePosition[0] + 1, 7 ) == -1 && get_cell(tilePosition[0], 4) == -1 && get_cell(tilePosition[0] + 1, 4) == -1 and  (!(tilePosition[0] in usedX) and !(tilePosition[0] + 1 in usedX) and !(tilePosition[0] - 1 in usedX)):
				#red and green safe zone visibility
				get_node("libraryFrame/good").visible = true
				get_node("libraryFrame/bad").visible = false
				#sets the safe frame at spot
				get_node("libraryFrame").position = Vector2(playerPosition[0], 395)
			else:
				get_node("libraryFrame").position = Vector2(playerPosition[0], 395)
				get_node("libraryFrame/good").visible = false
				get_node("libraryFrame/bad").visible = true
		elif buildingSelection == "frank":
			get_node("frankFrame").visible = true
			get_node("libraryFrame").visible = false
			get_node("statueFrame").visible = false
			if get_cell(tilePosition[0],7) == -1 &&  get_cell(tilePosition[0] + 1,7) == -1 &&  get_cell(tilePosition[0] + 2 ,7) == -1 &&  get_cell(tilePosition[0] + 3 ,7)  == -1 and (!(tilePosition[0] in usedX) and !(tilePosition[0] + 1 in usedX)  and !(tilePosition[0] + 2 in usedX) and !(tilePosition[0] + 3 in usedX)and !(tilePosition[0] - 1 in usedX)) and !(tilePosition[0] + -2 in usedX) and !(tilePosition[0] + -3 in usedX):
				get_node("frankFrame/good").visible = true
				get_node("frankFrame/bad").visible = false
				get_node("frankFrame").position = Vector2(playerPosition[0], 482)
			else:
				get_node("frankFrame").position = Vector2(playerPosition[0], 482)
				get_node("frankFrame/good").visible = false
				get_node("frankFrame/bad").visible = true
		elif buildingSelection == "statue":
			get_node("frankFrame").visible = false
			get_node("libraryFrame").visible = false
			get_node("statueFrame").visible = true
			if get_cell(tilePosition[0],7) == -1 && !(tilePosition[0] + 1 in usedX):
				get_node("statueFrame/good").visible = true
				get_node("statueFrame/bad").visible = false
				get_node("statueFrame").position = Vector2(playerPosition[0], 482)
			else:
				get_node("statueFrame").position = Vector2(playerPosition[0], 482)
				get_node("statueFrame/good").visible = false
				get_node("statueFrame/bad").visible = true

				
	else:
		get_node("frankFrame").visible = false
		get_node("libraryFrame").visible = false
		get_node("statueFrame").visible = false
		get_node("libraryFrame/good").visible = false
		get_node("libraryFrame/bad").visible = false
		get_node("frankFrame/good").visible = false
		get_node("frankFrame/bad").visible = false
		get_node("statueFrame/good").visible = false
		get_node("statueFrame/bad").visible = false
	if get_node("Player").get_position()[1] > 470:
		queue_free()
		get_tree().change_scene("res://src/Levels/FillerEnding.tscn")
#					set_cell(tilePosition[0],7,6)
func _input(event: InputEvent) -> void:
	#if the mouse is clicked
	if Input.is_action_just_pressed("spacebar"):
		if Global.material >0:
			var playerPosition = $Player.get_position()
			#changes the position of the would be tile to grid-spot in front of him
			playerPosition[0] += 64
			var tilePosition = world_to_map(playerPosition)
			#checks if theres another placed tile in the width of the library
			#FIX ME----
			if !(tilePosition[0] in usedX) and !(tilePosition[0] + 1 in usedX):
				
				#determines what to do with tiles based on desired tile placement
				if buildingSelection == "library":
					if get_cell(tilePosition[0],7) == -1 && get_cell(tilePosition[0] + 1, 7 ) == -1 && get_cell(tilePosition[0], 4) == -1 && get_cell(tilePosition[0] + 1, 4) == -1:
						print("library placed")
						Global.material -= 2
						#places library and fill with width of library
						set_cell(tilePosition[0], 4, 2)
						$buildSound.play()
						usedX.append(tilePosition[0])
						usedX.append(tilePosition[0] + 1)
						yield(get_tree().create_timer(3), "timeout")
						print("item despawning")
						set_cell(tilePosition[0], 4, -1)
						#Creates water hole tiles
						$iceBreakSound.play()
						set_cell(tilePosition[0], 8, 5)
						set_cell(tilePosition[0] +1, 8, 5)
						set_cell(tilePosition[0], 9, 5)
						set_cell(tilePosition[0] +1, 9, 5)

				elif buildingSelection == "frank":
					if get_cell(tilePosition[0],7) == -1 &&  get_cell(tilePosition[0] + 1,7) == -1 &&  get_cell(tilePosition[0] + 2 ,7) == -1 &&  get_cell(tilePosition[0] + 3 ,7)  == -1:
						print("frank placed")
						Global.material -= 2
						$buildSound.play()
						set_cell(tilePosition[0], 7, 3)
						usedX.append(tilePosition[0])
						usedX.append(tilePosition[0] + 1)
						usedX.append(tilePosition[0] + 2)
						usedX.append(tilePosition[0] + 3)
						yield(get_tree().create_timer(3), "timeout")
						set_cell(tilePosition[0], 7, -1)
						#queue_free()
						$iceBreakSound.play()
						set_cell(tilePosition[0], 8, 5)
						set_cell(tilePosition[0] +1, 8, 5)
						set_cell(tilePosition[0]+2, 8, 5)
						set_cell(tilePosition[0] +3, 8, 5)
						set_cell(tilePosition[0], 9, 5)
						set_cell(tilePosition[0] +1, 9, 5)
						set_cell(tilePosition[0]+2, 9, 5)
						set_cell(tilePosition[0] +3, 9, 5)
				
				elif buildingSelection == "statue":
					if get_cell(tilePosition[0],7) == -1:
						print("statue placed")
						Global.material -= 1
						$buildSound.play()
						set_cell(tilePosition[0], 7, 7)
						usedX.append(tilePosition[0])
						yield(get_tree().create_timer(3), "timeout")
						set_cell(tilePosition[0], 7, -1)
						$iceBreakSound.play()
						set_cell(tilePosition[0], 8, 5)
						set_cell(tilePosition[0], 9, 5)
						
					


func _on_Button_pressed() -> void:
	if toggleGuide == false:
		toggleGuide = true

