import 'package:catch_danger/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../DataBase/DataBaseHelper.dart';
import '../model/RoomModel.dart';
import 'ListRoom/homeScreen.dart';
import 'homeScreen.dart';


class AddRoomScreen extends StatefulWidget {
  static const String routeName = "AddRoom";

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  @override
  final _addKey = GlobalKey<FormState>();
  String _camraIP = '';
  String _floorNumber = '';
  String _roomName = '';
  bool isLoading = false;

  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Colors.white,
      ),
      SizedBox(
        height: 170,
        child: Image.asset("assets/images/Artboard 1 copy.png",
            fit: BoxFit.contain),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _addKey,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _camraIP = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Camra IP",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter camraIP';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _floorNumber = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Floor Number",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter floorNumber';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _roomName = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Room Name",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter roomName';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //bugs
                  isLoading
                      ? CircularProgressIndicator()
                      : Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      onPressed: () {
                        CreateRoom();

                      },
                      child:Text(
                        "Add Room",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
    ]);
  }

  void CreateRoom() {
    if (_addKey.currentState?.validate() != null) {
      RegisterRoom();
    }
  }

  void RegisterRoom() async {
    setState(() {
      this.isLoading = true;
    });
      final docRef =getRoomsCollectionWithConverter().doc();
      RoomModel room =RoomModel(roomId:docRef.id,
          roomName: _roomName,
          floorNumber:_floorNumber,
          camraIP:_camraIP);
      docRef.set(room).then((value){
        setState(() {
          isLoading=false;
        });
        Fluttertoast.showToast(msg: 'Room Added Successfully',
            toastLength: Toast.LENGTH_LONG);
        Navigator.pushReplacementNamed(context,  HomeScreen.routeName);
      });
  }

  void ShowMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message,
                style: TextStyle(
                    fontFamily: "Poppins", color: Colors.black, fontSize: 18)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()),);
                  },
                  child: Text("Ok", style: TextStyle(fontFamily: "Poppins")))
            ],
          );
        });
  }
}

_labels(String label) {
  return Center(
    child: Text(
      label,
      style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600),
    ),
  );
}