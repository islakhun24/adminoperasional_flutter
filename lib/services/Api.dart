// ignore_for_file: file_names

import 'dart:convert';

import 'package:admin_operasional/models/notif.dart';
import 'package:admin_operasional/models/project.dart';
import 'package:admin_operasional/models/response_dashboard.dart';
import 'package:admin_operasional/models/response_notif_count.dart';
import 'package:admin_operasional/models/response_project.dart';
import 'package:admin_operasional/models/smu.dart';

import '../constants/url.dart' show Url;
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

// const storage = FlutterSecureStorage();

class Api {
  Future<String?> login(String username, String password) async {
    var res = await http.post(Uri.parse(Url.LOGIN),
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<ResponseProject>   project() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse(Url.ADMIN_OPERASIONAL_GET_PROJECT),
        headers: {'x-access-token': jwt!});
    print('data :'+response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ResponseProject.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Smu>> adminSmu(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse(Url.ADMIN_OPERASIONAL_SMU + id.toString()),
        headers: {'x-access-token': jwt!});
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // final parsed = json.
      return smuFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Future<List<Notif>> notifs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse(Url.DASHBOARD_NOTIFS),
        headers: {'x-access-token': jwt!});
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // final parsed = json.
      return notifFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Future<bool> adminSelesai(List<Smu> fd, int id) async {
    var parsed = json.encode(fd);
    print(parsed);
    var res = await http.put(Uri.parse(Url.ADMIN_SELESAI+id.toString()),
        body: {
          'data': parsed
        });
    if (res.statusCode == 200) return true;
    return false;

  }
  Future<ResponseCountNotif> countNotif() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse(Url.DASHBOARD_COUNT_NOTIF),
        headers: {'x-access-token': jwt!});
    print('Data : '+response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ResponseCountNotif.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  Future<DashboardProject> dashboard() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse(Url.DASHBOARD),
        headers: {'x-access-token': jwt!});
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DashboardProject.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Smu>> dashboardStats(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse(Url.DASHBOARD_STATS+'/' + id.toString()),
        headers: {'x-access-token': jwt!});
    print('stats: '+response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // final parsed = json.
      return smuFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
