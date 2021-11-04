import 'package:admin_operasional/models/project.dart';
import 'package:admin_operasional/pages/empty.dart';
import 'package:admin_operasional/pages/smu_list.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {

  const ListPage({Key? key, this.data}) : super(key: key);
  final Project? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmuList(data: data),
    );
  }
}
