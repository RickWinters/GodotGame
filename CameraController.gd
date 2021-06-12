extends Camera2D

var requestedZoom : float = 4.0
var oldRequestedZoom : float = 4.0

var zoomFactor : float = 4.0
var zoomChangeFactor : float = 0.05
var zoomChangeCutoff : float = 0.05
var zoomDif : float = 0.0

#counters to keep track of when to change zoom level and when to reset
var zoomChangeCounter : int = 0 #change zoomlevel to requested when this counter reaches either "Cutoff or "ToNormal
var changeCounterCutoff : int = 30
var changecounterToNormal : int = 10
var changeCounterReset : int = 0 # reset zoomChangeCounter when this reach "Limit
var changeCounterResetLimit: int = 5

var normalZoomFactor : float = 3.5
var movingZoomFactor : float = 2.5

var _zoom : Vector2 = Vector2()

onready var player = get_node("/root/MainScene/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = player.position.x
	position.y = player.position.y
	update_zoom(delta)
	
func update_zoom(delta):
	# wait till changing zoom depending on if going to normal or not
	if requestedZoom != oldRequestedZoom:
		changeCounterReset = 0
		zoomChangeCounter += 1
		if requestedZoom == normalZoomFactor:
			if zoomChangeCounter == changecounterToNormal:
				oldRequestedZoom = requestedZoom
				zoomChangeCounter = 0
		else:
			if zoomChangeCounter == changeCounterCutoff:
				oldRequestedZoom = requestedZoom
				zoomChangeCounter = 0
	else:
		changeCounterReset += 1
		if changeCounterReset == changeCounterResetLimit:
			zoomChangeCounter = 0
			changeCounterReset = 0
	
	zoomDif = oldRequestedZoom - zoomFactor
	#if abs(zoomDif) < zoomChangeCutoff:
	#	zoomFactor = oldRequestedZoom
	#else:
	zoomFactor = zoomFactor + zoomDif*delta*(zoomChangeFactor/(delta+0.0000001))
	
	_zoom.x = 1.0 / zoomFactor
	_zoom.y = 1.0 / zoomFactor
	set_zoom(_zoom)
	
func _on_Player_Player_is_moving(is_moving):
	if is_moving:
		requestedZoom = movingZoomFactor
	else:
		requestedZoom = normalZoomFactor
	
	
	
	
	
