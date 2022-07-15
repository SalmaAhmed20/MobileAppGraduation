import 'package:catch_danger/model/RoomModel.dart';
import 'package:catch_danger/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

getUsersRefWithConventer() {
  return FirebaseFirestore.instance
      .collection(UserModel.COLLECTION_NAME)
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
    toFirestore: (users, _) => users.toJson(),
  );
}

CollectionReference<RoomModel> getRoomsCollectionWithConverter() {
  return FirebaseFirestore.instance
      .collection(RoomModel.COLLECTION_NAME)
      .withConverter<RoomModel>(
    fromFirestore: (snapshot, _) => RoomModel.fromJson(snapshot.data()!),
    toFirestore: (Room, _) => Room.toJson(),
  );
}
//
// CollectionReference<Message> getMessagesCollectionWithConverter(String roomId) {
//   final roomCollection = getRoomsCollectionWithConverter();
//   return roomCollection
//       .doc(roomId)
//       .collection(Message.COLLECTION_NAME)
//       .withConverter<Message>(
//     fromFirestore: (snapshot, _) => Message.fromJson(snapshot.data()!),
//     toFirestore: (message, _) => message.toJson(),
//   );
// }