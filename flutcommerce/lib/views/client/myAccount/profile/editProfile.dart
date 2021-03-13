import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutcommerce/core/constants.dart';
import 'package:flutcommerce/models/muser.model.dart';
import 'package:flutcommerce/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final Muser eUser;
  EditProfile({@required this.eUser});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // UserRepository _userRepository = UserRepository.instance();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _address = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String imageUrl;
  bool _uploading;
  bool _saving;
  @override
  void initState() {
    _name.text = widget.eUser.name;
    _phoneNumber.text = widget.eUser.phoneNumber.toString() == "null"
        ? ""
        : widget.eUser.phoneNumber.toString();
    _address.text = widget.eUser.address;
    imageUrl = widget.eUser.profilePhoto;
    _uploading = false;
    _saving = false;
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phoneNumber.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Future<String> uploadImageToStorage(File imageFile) async {
    //   Reference _storageReference;

    //   try {
    //     _storageReference = FirebaseStorage.instance
    //         .ref()
    //         .child('${DateTime.now().millisecondsSinceEpoch}');
    //     UploadTask storageUploadTask =
    //         _storageReference.putFile(imageFile);
    //     var url =
    //         await (await storageUploadTask).ref.getDownloadURL();
    //     return url.toString();
    //   } catch (e) {
    //     Utils.showToast(e.toString());
    //     return widget.eUser.profilePhoto;
    //   }
    // }

    // Future<String> pickImage({@required ImageSource source}) async {
    //   try {
    //     File selectedImage = await Utils.pickImage(source: source);
    //     if (selectedImage != null) {
    //       // Get url from the image bucket
    //       String url = await uploadImageToStorage(selectedImage);
    //       return url;
    //     } else {
    //       return widget.eUser.profilePhoto;
    //     }
    //   } catch (e) {
    //     Utils.showToast(e.toString());
    //     return widget.eUser.profilePhoto;
    //   }
    // }

    return Scaffold(
      // backgroundColor: bgCol,
      appBar: AppBar(
        leading: IconButton(
          icon: backIcon,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Edit Profile",
          // style: appTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //Profile
                  // !_uploading
                  //     ? Container(
                  //         child: CachedImage(
                  //           imageUrl,
                  //           isRound: true,
                  //           radius: 90.0,
                  //         ),
                  //       )
                  //     : 
                      CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  //For Profile Image
                  // widget.mode == 0?
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Change Profile Picture: ",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () async {
                          setState(() {
                            _uploading = true;
                          });
                          // await pickImage(source: ImageSource.gallery)
                          //     .then((value) {
                          //   setState(() {
                          //     imageUrl = value;
                          //     _uploading = false;
                          //   });
                          // });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
                          setState(() {
                            _uploading = true;
                          });
                          // await pickImage(source: ImageSource.camera)
                          //     .then((value) {
                          //   setState(() {
                          //     imageUrl = value;
                          //     _uploading = false;
                          //   });
                          // });
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  // Name
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) return "*This can't be empty.";
                      return null;
                    },
                    controller: _name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Full Name",
                      // labelStyle: TextStyle(color: Colors.black),
                      hintText: widget.eUser.name,
                      filled: true,
                      // fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Phone Number
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty || val.length != 10)
                        return "*This can't be empty or not equal to 10 numbers";
                      return null;
                    },
                    controller: _phoneNumber,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Phone Number",
                      // labelStyle: TextStyle(color: Colors.black),
                      hintText: widget.eUser.phoneNumber.toString() == "null"
                          ? ""
                          : widget.eUser.phoneNumber.toString(),
                      filled: true,
                      // fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Address
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) return "*This can't be empty.";
                      return null;
                    },
                    controller: _address,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      labelText: "Address",
                      // labelStyle: TextStyle(color: Colors.black),
                      hintText: widget.eUser.address,
                      filled: true,
                      // fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Save Button
                  const SizedBox(height: 20.0),
                  MaterialButton(
                    // color: mainCol,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    // textColor: Colors.white,
                    child:
                        !_saving ? Text("Save") : CircularProgressIndicator(),
                    onPressed: () async {
                      setState(() {
                        _saving = true;
                      });
                      Utils.hideKeyboard(textFieldFocus);
                      Muser upUser = Muser(
                        uid: widget.eUser.uid,
                        name: _name.text,
                        profilePhoto: imageUrl,
                        username: widget.eUser.username,
                        email: widget.eUser.email,
                        phoneNumber: Utils.strToInt(_phoneNumber.text),
                        address: _address.text,
                      );
                      if (_formKey.currentState.validate()) {
                        // if (await _userRepository.updateProfile(upUser) ==
                        //     true) {
                        //   // await _userRepository.refreshUser();
                        //   setState(() {
                        //     _saving = false;
                        //   });
                        //   Utils.showToast("Profile Updated Successfully");
                        //   Navigator.of(context).pop();
                        // } else {
                        //   Utils.showToast("Error while Updating Profile");
                        // }
                      } else {
                        setState(() {
                          _saving = false;
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
