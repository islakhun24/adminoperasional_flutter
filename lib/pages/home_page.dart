// import 'package:codedecoders/details.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:admin_operasional/models/project.dart';
import 'package:admin_operasional/models/response_dashboard.dart';
import 'package:admin_operasional/models/response_project.dart';
import 'package:admin_operasional/pages/empty.dart';
import 'package:admin_operasional/pages/list_page.dart';
import 'package:admin_operasional/pages/login_page.dart';
import 'package:admin_operasional/pages/project_page.dart';
import 'package:admin_operasional/services/Api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Api api = Api();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          child:Stack(
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: <Widget>[
              ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 4 / 7,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF6594BB),
                        Color(0xFF5A85A8),
                        Color(0xFF506C95),
                        Color(0xFF465682),
                        Color(0xFF3C5170),
                        Color(0xFF32395D),
                        Color(0xFF28314A),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 80,
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              Positioned(
                left: 20,
                top: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Hallo,",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        )),
                    const Text(
                        "Selamat datang di admin operasional \nsilahkan check smu dengan teliti dan benar.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ],
                ),
              ),

              Positioned(
                left: 20,
                top: 270,
                right: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          FutureBuilder<DashboardProject>(
                            future: api.dashboard(),
                            builder: (context, AsyncSnapshot<DashboardProject> snapshot){
                              return GestureDetector(
                                onTap: () {
                                  if(snapshot.hasData){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProjectPage(data: snapshot.data?.data)));
                                  }else{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EmptyProject()));
                                  }
                                },
                                child: _customCard(
                                    imageUrl: "box.png",
                                    item: "Dashboard",
                                    duration: "Project detail"),
                              );



                            },
                          ),
                          FutureBuilder<ResponseProject>(
                            future: api.project(),
                            builder: (context, AsyncSnapshot<ResponseProject> snapshot){
                              return GestureDetector(
                                onTap: () {
                                  if(snapshot.hasData){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListPage(data: snapshot.data?.data)));
                                  }else{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EmptyProject()));
                                  }
                                },
                                child: _customCard(
                                    imageUrl: "hourglass.png",
                                    item: "Approval",
                                    duration: "Kirim approval"),
                              );



                            },
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 450,
                right: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(

                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          FutureBuilder<DashboardProject>(
                            future: api.dashboard(),
                            builder: (context, AsyncSnapshot<DashboardProject> snapshot){
                              return GestureDetector(
                                  onTap: () {
                                    if(snapshot.hasData){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProjectPage(data: snapshot.data?.data)));
                                    }else{
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EmptyProject()));
                                    }
                                  },
                                  child: Container(
                                    child:  _customCard(
                                        imageUrl: "notifications.png",
                                        item: "Notifikasi",
                                        duration: "0 notifikasi baru"),
                                  )
                              );



                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              // print('asd');
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              await preferences.clear();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: _customCard(
                                imageUrl: "logout.png",
                                item: "Logout",
                                duration: "Keluar aplikasi"),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )

            ],
          )
      )

      // FutureBuilder<ResponseProject>(
      //   future: api.project(),
      //   builder: (context, AsyncSnapshot<ResponseProject> snapshot){
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       print(snapshot.data?.status);
      //       if(snapshot.data?.status == 1){
      //         return _body(true, snapshot.data?.data);
      //       }else{
      //         return _body(false, null);
      //       }
      //
      //     }else{
      //       return _body(false, null);
      //     }
      //
      //
      //   },
      // )

    );
  }

  _customCard({String? imageUrl, required String item, String? duration}) {
    return SizedBox(
      height: 168,
      width: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/" + imageUrl!, height: 60, width: 60,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item,
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(duration!)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class ClippingClass extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 120);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//
// class HomePage extends StatelessWidget {
//   Api api = Api();
//
//   @override
//   Widget build(BuildContext context) {
//     ResponseProject getData(){
//       var apis =  api.project() ;
//       ResponseProject parsedJson = ResponseProject.fromJson(apis);
//       return parsedJson;
//     }
//     // Project project = Project.fromJson(apis);
//     // print(project.id);
//     return Scaffold(
//       body: Stack(
//         overflow: Overflow.visible,
//         fit: StackFit.loose,
//         children: <Widget>[
//           ClipPath(
//             clipper: ClippingClass(),
//             child: Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 4 / 7,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xFF6594BB),
//                     Color(0xFF5A85A8),
//                     Color(0xFF506C95),
//                     Color(0xFF465682),
//                     Color(0xFF3C5170),
//                     Color(0xFF32395D),
//                     Color(0xFF28314A),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 20,
//             top: 80,
//             height: 60,
//             width: 60,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Image.asset("assets/images/logo.png"),
//             ),
//           ),
//           Positioned(
//             left: 20,
//             top: 150,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const Text("Hallo,",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                     )),
//                 const Text(
//                     "Selamat datang di admin operasional \nsilahkan check smu dengan teliti dan benar.",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     )),
//               ],
//             ),
//           ),
//         Positioned(
//               left: 20,
//               top: 270,
//               right: 20,
//               child: Column(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(context,
//                       // MaterialPageRoute(builder: (context) => Detailes()));
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ProjectPage()));
//                           },
//                           child: _customCard(
//                               imageUrl: "box.png",
//                               item: "Tugas 1",
//                               duration: "sedang berjalan"),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ListPage()));
//                           },
//                           child: _customCard(
//                               imageUrl: "hourglass.png",
//                               item: "Permintaan",
//                               duration: "Tugas 1"),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 40,
//                   ),
//                 ],
//               ),
//             )
//
//           ],
//       ),
//     );
//   }
//
//   _customCard({String? imageUrl, required String item, String? duration}) {
//     return SizedBox(
//       height: 168,
//       width: 150,
//       child: Card(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         elevation: 10,
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Image.asset("assets/images/" + imageUrl!),
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       item,
//                       style: const TextStyle(fontSize: 24),
//                     ),
//                     Text(duration!)
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ClippingClass extends CustomClipper<Path> {
//
//
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0.0, size.height);
//     var controlPoint = Offset(size.width - (size.width / 2), size.height - 120);
//     var endPoint = Offset(size.width, size.height);
//     path.quadraticBezierTo(
//         controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
//     path.lineTo(size.width, 0.0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
