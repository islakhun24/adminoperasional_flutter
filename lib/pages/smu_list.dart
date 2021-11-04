import 'package:admin_operasional/models/project.dart';
import 'package:admin_operasional/models/smu.dart';
import 'package:admin_operasional/pages/home_page.dart';
import 'package:admin_operasional/services/Api.dart';
import 'package:flutter/material.dart';


class SmuList extends StatefulWidget {
  const SmuList({Key? key, this.data}) : super(key: key);
  final Project? data;

  @override
  _SmuListState createState() => _SmuListState();
}

class _SmuListState extends State<SmuList> {
  late  Api api;
  late Future<List<Smu>> futurePost ;
  late List<Smu> smu;
  @override
  void initState(){
    super.initState();
    api = Api();
    smu =[];
    futurePost= api.adminSmu(widget.data!.id);
    futurePost.then((value) => print(smu = value));
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          header(context),
          Positioned(
              top: 210,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Card(
                  color: Colors.white,

                  // margin: EdgeInsets.only(top: -40),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar SMU',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: FutureBuilder<List<Smu>>(
                            builder: (context, snapshot){
                              smu = snapshot.data!;
                                return Container(
                                  height:MediaQuery.of(context).size.height,
                                  child: ListView.separated(
                                    itemBuilder: (context, int index){
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(smu[index].smu.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                            Container(
                                              margin: const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: [
                                                  Expanded(flex:1, child:Text(smu[index].koli.toString() + ' koli')),
                                                  Expanded(
                                                      flex:1,
                                                      child:  Text(smu[index].berat_total.toString()+ ' Kg')),
                                                  Expanded(flex:1, child: Text(smu[index].status.toString()))
                                                ],
                                              ),
                                            )
                                      ],),);
                                    },
                                    itemCount: smu.length,
                                    separatorBuilder:  (context, index) => Divider(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                );
                            },
                            future: futurePost,
                          )

                        )
                      ],
                    ),
                  ),
                ),
              ),
          )
        ],
      ),
    ));
  }

  Widget header(BuildContext context) {
    return Container(
        height: 250,
        decoration: const BoxDecoration(
          // ignore: unnecessary_const
          gradient: const LinearGradient(
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      widget.data!.no,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [

                        cardSmu(
                            context,
                            'Pengemudi',
                            widget.data!.nama_pengemudi ),
                        cardSmu(context, 'No Kendaraan', widget.data!.no_polisi_kendaraan),
                        cardSmu(context, 'TPS', widget.data!.asal_tps)
                      ],
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.topRight,
                  child: RaisedButton(
                    color: Colors.blue,
                    splashColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: () async {
                      _showMyDialog(context);
                      //
                      // api.adminSelesai(newData, widget.data!.id);
                    },
                    child: Text(
                      'Kirim Approval',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }



  Widget cardSmu(BuildContext context, String header, String desc) {
    return Expanded(
        flex: 1,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  header,
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w100,
                      fontSize: 12),
                  textAlign: TextAlign.left,
                ),
                Text(
                  desc,
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Kirim approval.'),
                Text('Apakah anda yakin ingin mengirim approval?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak', style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                api.adminSelesai(smu.toList(), widget.data!.id).then((res) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                });
              },
            ),

          ],
        );
      },
    );
  }
}

