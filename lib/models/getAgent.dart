import 'dart:convert';


GetAgent getAgentFromJson(String str) => GetAgent.fromJson(json.decode(str));


class GetAgent {

  final String id;

  final String userid;

  final String uid;

  final String company;

  final String hqAddress;

  final String workingHrs;


  GetAgent({

    required this.id,

    required this.userid,

    required this.uid,

    required this.company,

    required this.hqAddress,

    required this.workingHrs,

  });


  factory GetAgent.fromJson(Map<String, dynamic> json) => GetAgent(

        id: json["_id"],

        userid: json["userid"],

        uid: json["uid"],

        company: json["company"],

        hqAddress: json["hq_address"],

        workingHrs: json["working_hrs"],

      );

}

