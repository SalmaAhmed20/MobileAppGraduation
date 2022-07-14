import 'package:catch_danger/Screens/addRoom.dart';
import 'package:catch_danger/model/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DataBase/DataBaseHelper.dart';
import 'ListRoom/homeScreen.dart';
import 'homeScreen.dart';


class AddUserScreen extends StatefulWidget {
  static const String routeName = "AddUser";

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  final _addKey = GlobalKey<FormState>();
  String _uid = '';
  String _email = '';
  String _password = '';
  String _firstName = '';
  String _secondName = '';
  bool _obscureText = true;
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
                      _firstName = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter firstname';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _secondName = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Second Name",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter secondname';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _email = newVal;
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter E-mail';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (newVal) {
                      _password = newVal;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            size: 28,
                            color: Colors.indigo,
                          ),
                          onPressed: () {
                            _toggle();
                          },
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF797979)),
                        floatingLabelBehavior: FloatingLabelBehavior.auto),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      } else if (value.length < 6)
                        return "Password should be at least 6 characters";
                      return null;
                    },
                    onSaved: (val) => _password = val!,
                    obscureText: _obscureText,
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
                        CreateUser();

                      },
                      child:Text(
                        "Add User",
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

  //used in show and hide password
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void CreateUser() {
    if (_addKey.currentState?.validate() != null) {
      RegisterUser();
    }
  }

  void RegisterUser() async {
    setState(() {
      this.isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: this._email, password: this._password);
      ShowMessage("Sucess");
      final userRef =getUsersRefWithConventer();
      final user = UserModel(uid: userCredential.user!.uid, email: _email,
          firstName: _firstName, secondName: _secondName, password: _password);
      userRef.doc(user.uid).set(user).then((value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),);
      });
    } on FirebaseAuthException catch (e) {
      ShowMessage(e.message ?? "Something went wrong");
    } catch (e) {
      print(e);
    }
    setState(() {
      this.isLoading = false;
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
                      MaterialPageRoute(builder: (context) => AddRoomScreen()),);
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