import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  //name
  static Future<bool> saveName(String name) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('name', name);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('name');
  }

  //profile Photo
  static Future<bool> saveProfilePhoto(String profilePhoto) async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('profilePhoto', profilePhoto);
    return true;
    }catch(e){
      return false;
    }
  }

  static Future<String> getProfilePhoto() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('profilePhoto');
  }
  //user Id
  static Future<bool> saveUserId(String userId) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('userId', userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getuserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('userId');
  }
  
  //address
  static Future<bool> saveUserAddress(String address) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('address', address);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getuserAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('address');
  }
  //email address
  static Future<bool> saveUserEmail(String email) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('email', email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getuserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('email');
  }
  //Phone Number
  static Future<bool> saveUserPhoneNumber(int phoneNumber) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('phoneNumber', phoneNumber);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> getuserPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('phoneNumber');
  }
  //device location
  static Future<bool> saveDeciceAddress(String deviceAddress) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('deviceAddress', deviceAddress);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getDeviceAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('deviceAddress');
  }
}
