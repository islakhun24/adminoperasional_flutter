// ignore_for_file: constant_identifier_names

class Url {
  static const BASE_URL = "http://localhost:8080/api";
  // static const BASE_URL = "https://regulated-agen-backend.herokuapp.com/api";
  static const LOGIN = "$BASE_URL/auth/signin";
  static const ADMIN_OPERASIONAL_GET_PROJECT = "$BASE_URL/main2/projek/admin";
  static const ADMIN_OPERASIONAL_SMU = "${BASE_URL}/main2/projek/admin/smu/";
  static const ADMIN_SELESAI = "${BASE_URL}/main2/projek/admin/smu/";
  static const DASHBOARD = "${BASE_URL}/mobile/admin/project";
  static const DASHBOARD_STATS = "${BASE_URL}/mobile/admin/project/stats";
}