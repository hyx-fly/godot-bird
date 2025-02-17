const PROTOCOL_ID = 102
const PROTOCOL_CLASS_NAME = "Heartbeat"




func map() -> Dictionary:
	var map = {}

	return map

func _to_string() -> String:
	return JSON.stringify(map())

static func write(buffer, packet):
	if (buffer.writePacketFlag(packet)):
		return
	

static func read(buffer):
	if (!buffer.readBool()):
		return null
	var packet = buffer.newInstance(PROTOCOL_ID)
	
	return packet
