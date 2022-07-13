class RoomModel {
  static const COLLECTION_NAME='Room';
  late String camraIP;
  late String floorNumber;
  late String roomId;
  late String roomName;

  RoomModel({ required this.camraIP,
    required this.floorNumber,
    required this.roomId,
    required this.roomName,
  });

  // receiving data from server
  RoomModel.fromJson(Map<String ,dynamic>json):this(
    camraIP : json['camraIP'] as String,
    floorNumber : json['floorNumber'] as String,
    roomId : json['roomId'] as String,
    roomName : json['roomName'] as String,
  );

  // sending data to our server
  Map<String , Object>toJson(){
    return{
      'camraIP': camraIP,
      'floorNumber': floorNumber,
      'roomId': roomId,
      'roomName': roomName,
    };
  }
}