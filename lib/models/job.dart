// model generated from quicktype

// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

Job jobFromJson(String str) => Job.fromJson(json.decode(str));

String jobToJson(Job data) => json.encode(data.toJson());

class Job {
  final String title;
  final String location;
  final String company;
  final String description;
  final String salary;
  final String agentName;
  final String contract;
  final bool hiring;
  final String period;
  final String imageUrl;
  final String agentId;
  final List<String> requirements;

  Job({
    required this.title,
    required this.location,
    required this.company,
    required this.description,
    required this.salary,
    required this.agentName,
    required this.contract,
    required this.hiring,
    required this.period,
    required this.imageUrl,
    required this.agentId,
    required this.requirements,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        title: json["title"],
        location: json["location"],
        company: json["company"],
        description: json["description"],
        salary: json["salary"],
        agentName: json["agentName"],
        contract: json["contract"],
        hiring: json["hiring"],
        period: json["period"],
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "company": company,
        "description": description,
        "salary": salary,
        "agentName": agentName,
        "contract": contract,
        "hiring": hiring,
        "period": period,
        "imageUrl": imageUrl,
        "agentId": agentId,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
      };
}
