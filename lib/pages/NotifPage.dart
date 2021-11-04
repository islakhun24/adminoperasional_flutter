import 'package:admin_operasional/models/notif.dart';
import 'package:admin_operasional/services/Api.dart';
import 'package:flutter/material.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  late  Api api;
  late Future<List<Notif>> futurePost ;
  late List<Notif> notifs;

  @override
  void initState(){
    super.initState();
    notifs = [];
    api = Api();
    futurePost = api.notifs();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3C5170),
        title: Text('Notifikasi'),
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: ()=> Navigator.pop(context, false),
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<Notif>>(
          builder: (context, snapshot){
              if(snapshot.hasData && snapshot.data!.length != 0){
                notifs = snapshot.data!;
                return ListView.builder(
                    itemBuilder: (context, index){
                      return card_notif(context, notifs[index]);
                    },
                    itemCount: notifs.length,
                );
              }else{
                return notfound();
              }
          },
          future: futurePost,
        )
      ),
    );
  }
}
Widget card_notif(BuildContext context, Notif notif){
  return Card(
    color: Colors.white,
    // width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration:  BoxDecoration(
                color: Color(0xFF6594BB),
                borderRadius: BorderRadius.circular(4),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.notifications_sharp, color:  Color(0xFF3C5170),),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text('${notif.from}, ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${notif.header}.')
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Text('${notif.message}'),
                ),
                Positioned(
                    right: 0,
                    child:  Container(
                      margin: const EdgeInsets.only(top: 2),
                      child: Text('${notif.createdAt}'),
                    ))
              ],
            ),
          ),
          if (notif.read == 0) Container(
                decoration:  BoxDecoration(
                  color: Color(0xFF6594BB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4, right: 16,left: 16, bottom: 4 ),
                  child: Text('New', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10),),
                ),
              )
        ],
      ),
    ),
  );
}

Widget notfound(){
  return Center();
}
