import 'dart:convert';

String createAgentToJson(createAgent data) => json.encode(data.toJson());

class createAgent {
  createAgent({
    required this.uid,
    required this.working_hrs,
    required this.hq_address,
    required this.company,
  });

  final String uid;
  final String working_hrs;
  final String hq_address;
  final String company;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "working_hrs": working_hrs,
        "hq_address": hq_address,
        "company": company,
      };
}
