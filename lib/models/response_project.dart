import 'package:admin_operasional/models/project.dart';

class ResponseProject {
  int status;
  Project data;
  ResponseProject({required this.status, required this.data});
  factory ResponseProject.fromJson(Map<String, dynamic> json) {
    return ResponseProject(
        status: json['status'], data: Project.fromJson(json['data']));
  }
}
