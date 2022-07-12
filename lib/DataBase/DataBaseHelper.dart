import 'package:catch_danger/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

getUsersRefWithConventer() {
  return FirebaseFirestore.instance
      .collection(UserModel.COLLECTION_NAME)
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
    toFirestore: (users, _) => users.toJson(),
  );
}

// CollectionReference<Room> getRoomsCollectionWithConverter() {
//   return FirebaseFirestore.instance
//       .collection(Room.COLLECTION_NAME)
//       .withConverter<Room>(
//     fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
//     toFirestore: (room, _) => room.toJson(),
//   );
// }
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