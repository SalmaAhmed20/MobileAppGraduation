import 'package:catch_danger/Screens/addRoom.dart';
import 'package:catch_danger/model/RoomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DataBase/DataBaseHelper.dart';
import 'RoomWidget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';
  late CollectionReference<RoomModel> roomsCollectionref;
  HomeScreen() {
    roomsCollectionref = getRoomsCollectionWithConverter();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,

          ),

        ),
        Image(
          image: AssetImage('assets/images/Artboard 1 copy.png'),
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRoomScreen()),
              );
            },
            child: Icon(Icons.add),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 64, bottom: 12, left: 12, right: 12),
            child: FutureBuilder<QuerySnapshot<RoomModel>>(
                future: roomsCollectionref.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<RoomModel>> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final List<RoomModel> roomsList = snapshot.data?.docs
                        .map((singleDoc) => singleDoc.data())
                        .toList() ??
                        [];
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: .75/1,

                      ),
                      itemBuilder: (buildContext, index) {
                        return RoomWidget(roomsList[index]);
                      },
                      itemCount: roomsList.length,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        )
      ],
    );
  }
}