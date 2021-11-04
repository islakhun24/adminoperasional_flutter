import 'package:admin_operasional/models/project.dart';

class ResponseCountNotif {
  int? jumlah;
  ResponseCountNotif({required this.jumlah});
  factory ResponseCountNotif.fromJson(Map<String, dynamic> json) {
    return ResponseCountNotif(
        jumlah: json['jumlah']);
  }
}
