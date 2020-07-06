class User{
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  User({this.uid, this.firstName, this.lastName, this.email});

  factory User.fromMap(Map<String, dynamic> data){
    return User(
      uid: data["uid"],
      firstName: data["firstName"],
      lastName: data["lastName"],
      email: data["email"],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'uid':uid,
      'firstName':firstName,
      'lastName':lastName,
      'email':email,
    };
  }
}