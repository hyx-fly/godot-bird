const PROTOCOL_ID = 400
const PROTOCOL_CLASS_NAME = "PlayerInfo"


var id: int
var name: String
var avatar: String
var level: int
var exp: int

func map() -> Dictionary:
	var map = {}
	map["id"] = id
	map["name"] = name
	map["avatar"] = avatar
	map["level"] = level
	map["exp"] = exp
	return map

func _to_string() -> String:
	return JSON.stringify(map())

static func write(buffer, packet):
	if (buffer.writePacketFlag(packet)):
		return
	buffer.writeString(packet.avatar)
	buffer.writeLong(packet.exp)
	buffer.writeLong(packet.id)
	buffer.writeInt(packet.level)
	buffer.writeString(packet.name)

static func read(buffer):
	if (!buffer.readBool()):
		return null
	var packet = buffer.newInstance(PROTOCOL_ID)
	var result0 = buffer.readString()
	packet.avatar = result0
	var result1 = buffer.readLong()
	packet.exp = result1
	var result2 = buffer.readLong()
	packet.id = result2
	var result3 = buffer.readInt()
	packet.level = result3
	var result4 = buffer.readString()
	packet.name = result4
	return packet
