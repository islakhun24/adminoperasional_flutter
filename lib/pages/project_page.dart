import 'package:admin_operasional/models/project.dart';
import 'package:admin_operasional/pages/dashboard_stats_page.dart';
import 'package:admin_operasional/pages/empty.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {

  const ProjectPage({Key? key, this.data}) : super(key: key);
  final Project? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardStatPage(data: data),
    );
  }
}
