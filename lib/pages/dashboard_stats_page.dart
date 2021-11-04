import 'package:admin_operasional/models/project.dart';
import 'package:admin_operasional/models/smu.dart';
import 'package:admin_operasional/pages/home_page.dart';
import 'package:admin_operasional/services/Api.dart';
import 'package:flutter/material.dart';

class DashboardStatPage extends StatefulWidget {
  const DashboardStatPage({Key? key, this.data}) : super(key: key);
  final Project? data;
  @override
  _DashboardStatPageState createState() => _DashboardStatPageState();
}

class _DashboardStatPageState extends State<DashboardStatPage> {
  late  Api api;
  late Future<List<Smu>> futurePost ;
  late List<Smu> newData;
  @override
  void initState(){
    super.initState();
    api = Api();
    newData = [];
    futurePost= api.dashboardStats(widget.data!.id);
    futurePost.then((value) => newData = value);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  header(context, widget.data),
                  Positioned(
                    top: 210,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child:  Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Container(height: 8),
                                        Text('No. Do', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                                        Container(height: 2),
                                        Text(widget.data!.no, style: TextStyle(color: Color(0xFF3C5170), fontWeight: FontWeight.bold, fontSize: 14 ),),
                                        Container(height: 8),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Container(height: 8),
                                        Text('Team', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                                        Container(height: 2),
                                        Text('Team '+ widget.data!.team.toString(), style: TextStyle(color: Color(0xFF3C5170), fontWeight: FontWeight.bold, fontSize: 14 ),),
                                        Container(height: 8),
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 1,
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Container(height: 8),
                                        Text('Status', style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                                        Container(height: 2),
                                        Text( widget.data!.selesai != 4 ? 'di proses': 'Selesai', style: TextStyle(color: Color(0xFF3C5170), fontWeight: FontWeight.bold, fontSize: 14 ),),
                                        Container(height: 8),
                                      ],
                                    ),
                                  ),
                                )
                            )
                          ],
                        )
                        ,
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.all(16),
                child:  FutureBuilder<List<Smu>>(
                  builder: (context, snapshot){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Total:  ('+newData.length.toString() +' Smu)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        Flexible(child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            height:MediaQuery.of(context).size.height,
                            child:Container(
                              height:MediaQuery.of(context).size.height,
                              child: newData.length == 0 ? Text('Data tidak ada'): ListView.builder(
                                itemBuilder: (context, int index){
                                  return item_card(context, newData[index]);
                                    // Padding(
                                    // padding: EdgeInsets.all(8),
                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text(newData[index].smu.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                    //     Container(
                                    //       margin: const EdgeInsets.only(top: 4),
                                    //       child: Row(
                                    //         children: [
                                    //           Expanded(flex:1, child:Text(newData[index].koli.toString() + ' koli')),
                                    //           Expanded(
                                    //               flex:1,
                                    //               child:  Text(newData[index].berat_total.toString()+ ' Kg')),
                                    //           Expanded(flex:1, child: Text(newData[index].status.toString()))
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],),);
                                },
                                itemCount: newData.length,
                                // separatorBuilder:  (context, index) => Divider(
                                //   color: Colors.grey.shade300,
                                // ),
                              ),

                            )



                        ))
                      ],
                    );
                  },
                  future: futurePost,
                )


              ))
            ],
          )
        )
    );
  }
}

Widget header(BuildContext context, Project? widget) {

  return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
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
                    'Dashboard Stats',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top:16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tugas saat ini', style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w400),),
                      Padding(padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(widget!.kota_asal + ' - ' + widget.kota_tujuan , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:
                      Color(0xFF3C5170),),),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                      child: Divider(
                        color: Colors.grey.shade100,
                        thickness: 1.0,
                      ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text('Pengemudi', style: TextStyle(fontSize: 12, color: Colors.grey.shade400),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(widget.nama_pengemudi, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text('No. Kendaraan', style: TextStyle(fontSize: 12, color: Colors.grey.shade400),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(widget.no_polisi_kendaraan, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text('Asal TPS', style: TextStyle(fontSize: 12, color: Colors.grey.shade400),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(widget.asal_tps, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ));
}


Widget item_card(BuildContext context, Smu? widget){
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4, right: 8, left: 8),
      child:  Card(
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(widget!.smu!, style: TextStyle(fontWeight: FontWeight.bold),),
              // Container(
              //   margin: const EdgeInsets.only(top:2, bottom: 2),
              //   child: Divider(
              //       color: Colors.grey.shade300
              //   ),
              // ),
              Row(
                children: [
                  Text('No Smu : '),
                  Text(widget!.smu!)
                ],
              ),
              Row(
                children: [
                  Text('Nama Barang : '),
                  Text(widget.nama_barang!)
                ],
              ),
              Row(
                children: [
                  Text('Nama Agen : '),
                  Text(widget.nama_agen!)
                ],
              ),
              Row(
                children: [
                  Text('Warehouse : '),
                  Text(widget.warehouse!)
                ],
              ),
              Row(
                children: [
                  Text('Maskapai : '),
                  Text(widget.maskapai!)
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top:2, bottom: 2),
                child: Divider(
                    color: Colors.grey.shade300
                ),
              ),
              Center(
                child: Text('Berat', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('awal'),
                          Text(widget.berat_awal!.toString(), style: TextStyle(fontWeight: FontWeight.w200),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Recharge'),
                          Text(widget.berat_recharge_cargo!.toString(), style: TextStyle(fontWeight: FontWeight.w200),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Akhir'),
                          Text(widget.berat_total!.toString(), style: TextStyle(fontWeight: FontWeight.w200),)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
}
