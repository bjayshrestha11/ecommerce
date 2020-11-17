class Muser {
  String uid;
  String name;
  String email;
  String username;
  String profilePhoto;
  int phoneNumber;
  String address;

  Muser({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.profilePhoto,
    this.phoneNumber,
    this.address,
  });

  Map toMap(Muser user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['username'] = user.username;
    data["profile_photo"] = user.profilePhoto;
    data["phoneNumber"] = user.phoneNumber;
    data['address'] = user.address;
    return data;
  }

  // Named constructor
  Muser.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
    this.phoneNumber = mapData['phoneNumber'];
    this.address = mapData['address'];
  }
}