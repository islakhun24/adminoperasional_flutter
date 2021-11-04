
import 'dart:convert';


class Notif {
  int? id;
  String? header;
  String? message	;
  String? from;
  String? to;
  String? team;
  int? read;
  int? project_id;
  String? createdAt;
  String? updatedAt;

  Notif({
    required this.id,
    required this.header,
    required this.message,
    required this.from,
    required this.to,
    required this.team,
    required this.read,
    required this.project_id,
    required this.createdAt,
    required this.updatedAt
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
      project_id: json['project_id'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']
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
      'project_id':project_id,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

  @override
  String toString() {
    return 'Smu{id:$id, header:$header, message:$message, from:$from, to:$to, team:$team, read:$read, project_id:$project_id}}, createdAt:$createdAt}, updatedAt:$updatedAt}}';
  }
}
List<Notif> notifFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Notif>.from(data.map((item) => Notif.fromJson(item)));
}

String notifToJson(Notif data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}