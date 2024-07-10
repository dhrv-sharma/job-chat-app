import 'dart:convert';


ProfileRes profileResFromJson(String str) =>

    ProfileRes.fromJson(json.decode(str));


String createprofileRequestToJson(ProfileRes data) =>

    json.encode(data.toJson());


class ProfileRes {

  ProfileRes(

      {required this.id,

      required this.username,

      required this.email,

      // required this.isAdmin,

      required this.isAgent,

      required this.skills,

      required this.profile,

      required this.resume,

      required this.uid});


  final String id;

  final String username;

  final String email;

  // final bool isAdmin;

  final bool isAgent;

  final List<dynamic> skills;

  final String profile;

  final String resume;

  final String uid;


  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(

      id: json["_id"],

      username: json["username"],

      email: json["email"],


      // isAdmin: json["isAdmin"],


      isAgent: json["isAgent"],

      skills: json['skills'],

      profile: json["profile"],

      uid: json["uid"],

      resume: json["resume"]);


  Map<String, dynamic> toJson() => {

        "username": username,

        "email": email,

        "id": id,

        "isAgent": isAgent,

        "profile": profile,

        "resume": resume,

        "uid": uid,

        "skills": List<dynamic>.from(skills.map((x) => x))

      };

}

