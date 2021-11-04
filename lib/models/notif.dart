
import 'dart:convert';


class Notif {
  int? id;
  String? header;
  String? message	;
  String? from;
  String? to;
  String? team;
  String? read;
  String? project_id;

  Notif({
    required this.id,
    required this.header,
    required this.message,
    required this.from,
    required this.to,
    required this.team,
    required this.read,
    required this.project_id
  });

  factory Notif.fromJson(Map<String, dynamic> json)  {
    return Notif(
      id: json['id'],
      header: json['header'],
      message: json['message'],
      from: json['from'],
      to: json['to'],
      team: json['team'],
      read: json['read'],
      project_id: json['project_id']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'header':header,
      'message':message,
      'from':from,
      'to':to,
      'team':team,
      'read':read,
      'project_id':project_id
    };
  }

  @override
  String toString() {
    return 'Smu{id:$id, header:$header, message:$message, from:$from, to:$to, team:$team, read:$read, project_id:$project_id}';
  }
}
List<Notif> smuFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Notif>.from(data.map((item) => Notif.fromJson(item)));
}

String smuToJson(Notif data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}