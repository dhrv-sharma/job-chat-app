import 'dart:convert';


List<Agents> agentsFromJson(String str) =>

    List<Agents>.from(json.decode(str).map((x) => Agents.fromJson(x)));


class Agents {

  final String username;

  final String uid;

  final String profile;

  final String userid;


  Agents({

    required this.username,

    required this.uid,

    required this.profile,

    required this.userid,

  });


  factory Agents.fromJson(Map<String, dynamic> json) => Agents(

        username: json["username"],

        uid: json["uid"],

        profile: json["profile"],

        userid: json["_id"],

      );

}

