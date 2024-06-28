import 'dart:io';


import 'package:cloudinary_public/cloudinary_public.dart';


import 'package:file_picker/file_picker.dart';


import 'package:get/get.dart';


import 'package:get/get_core/src/get_main.dart';


import 'package:jobchat/controllers/exports.dart';


import 'package:jobchat/services/jobhelper.dart';


import 'package:flutter/material.dart';


import 'package:jobchat/constants/app_constants.dart';


import 'package:jobchat/models/auth/profile_model.dart';


import 'package:jobchat/services/authHelper.dart';


import 'package:jobchat/view/screen/home/mainscreen.dart';


import 'package:provider/provider.dart';


import 'package:shared_preferences/shared_preferences.dart';


class ProfileNotifier extends ChangeNotifier {

  bool companyLogo = false;


  bool get _companyLogo => companyLogo;


  set _companyLogo(bool current) {

    companyLogo = current;


    notifyListeners();

  }


// picking images from the gallery for adding job


  File? newJobImg;


  File? get _newJobImg => newJobImg;


  void newJobImage() async {

    FilePickerResult? result =

        await FilePicker.platform.pickFiles(type: FileType.image);


    if (result != null) {

      File file = File(result.files.first.path!);


      newJobImg = file;


      companyLogo = true;


      notifyListeners();


      return;

    }


    companyLogo = false;

  }


  // uploading image from the gallery


  String uploadedImage = "";


  String get _uploadedImage => uploadedImage;


  Future uploadImage(

      String agentName, String model, BuildContext context) async {

    try {

      final cloudinary = CloudinaryPublic("dap69mong", "rwdctipx");


      CloudinaryResponse res = await cloudinary.uploadFile(

          CloudinaryFile.fromFile(newJobImg!.path, folder: agentName));


      uploadedImage = res.secureUrl;


      addJob(model, context);

    } catch (e) {

      print(e.toString());

    }

  }


  void addJob(String model, BuildContext context) {

    jobHelper.createJob(model).then((response) {

      if (response == true) {

        uploadedImage = "";


        newJobImg = null;


        companyLogo = false;


        Get.snackbar(

            "Job has been Created", "Now people can apply to yout post",

            colorText: Color(kLight.value),

            backgroundColor: Colors.green,

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);


        var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);


        zoomNotifier.currentIndex = 0;


        uploadJob(false);


        Get.offAll(const mainScreen());

      } else {

        Get.snackbar("Something went Wrong", "Please try again",

            colorText: Color(kLight.value),

            backgroundColor: Color(kOrange.value),

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);


        uploadJob(false);

      }

    });

  }


  late Future<ProfileRes?> myProfile;


  String _profileImage = profileConst;


  String get profileImage => _profileImage;


  set profileImage(String url) {

    _profileImage = url;


    notifyListeners();

  }


  Future<ProfileRes?> get getProfile => myProfile;


  void profileSet() {

    myProfile = authHelper.getProfile();

  }


  File? editProfilePicture;


  String? uploadedProfile;


  bool editProfile = false;


  bool get _edited => editProfile;


  File? get _editProfilePicture => editProfilePicture;


  void selectPicture() async {

    FilePickerResult? result =

        await FilePicker.platform.pickFiles(type: FileType.image);


    if (result != null) {

      File file = File(result.files.first.path!);


      editProfilePicture = file;


      editProfile = true;


      notifyListeners();


      return;

    }


    editProfile = false;

  }


  Future uploadProfile(String userName) async {

    try {

      final cloudinary = CloudinaryPublic("dap69mong", "rwdctipx");


      CloudinaryResponse res = await cloudinary.uploadFile(

          CloudinaryFile.fromFile(editProfilePicture!.path, folder: userName));


      uploadedProfile = res.secureUrl;

    } catch (e) {

      print(e.toString());

    }

  }


  void updateProfile(String model, BuildContext context, ProfileRes res) async {

    authHelper.updateProfile(model).then((response) async {

      if (response == true) {

        Get.snackbar(

            "Profile Updated", "Now People can see your updated Profile",

            colorText: Color(kLight.value),

            backgroundColor: Colors.green,

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);


        var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);


        zoomNotifier.currentIndex = 4;


        final SharedPreferences prefs = await SharedPreferences.getInstance();


        profileImage = res.profile;


        await prefs.setString('profile', res.profile);


        await prefs.setString('username', res.username);


        updates(false);


        Get.offAll(const mainScreen());

      } else {

        Get.snackbar("Something went Wrong", "Please try again",

            colorText: Color(kLight.value),

            backgroundColor: Color(kOrange.value),

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);


        updates(false);

      }

    });

  }


  bool updatingProfile = false;


  bool get _updatingProfile => updatingProfile;


  void updates(bool newUpdate) {

    updatingProfile = newUpdate;


    notifyListeners();

  }


  bool uploadingJob = false;


  bool get _uploadingJob => uploadingJob;


  void uploadJob(bool current) {

    uploadingJob = current;


    notifyListeners();

  }

}

