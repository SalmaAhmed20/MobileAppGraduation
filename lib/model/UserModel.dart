class UserModel {
  static const COLLECTION_NAME='users';
  late String uid;
  late String email;
  late String firstName;
  late String secondName;
  late String password;

  UserModel({ required this.uid,
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.password,
   });

  // receiving data from server
  UserModel.fromJson(Map<String ,dynamic>json):this(
    uid : json['uid'] as String,
    email : json['email'] as String,
    firstName : json['firstName'] as String,
    secondName : json['secondName'] as String,
    password : json['password'] as String,
    );

  // sending data to our server
  Map<String , Object>toJson(){
    return{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'password': password,
    };
  }
}