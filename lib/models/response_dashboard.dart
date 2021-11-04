import 'package:admin_operasional/models/project.dart';

class DashboardProject {
  int status;
  Project data;
  DashboardProject({required this.status, required this.data});
  factory DashboardProject.fromJson(Map<String, dynamic> json) {
    return DashboardProject(
        status: json['status'], data: Project.fromJson(json['data']));
  }
}
