
import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/devices/electricity/iron_page.dart';
import 'package:hackaton_front/UI/forms/devices/electricity/kettle_page.dart';
import 'package:hackaton_front/UI/forms/views/security_page.dart';
import 'package:hackaton_front/UI/forms/views/health_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';


class ElectricalPage extends StatefulWidget {
  const ElectricalPage({super.key});

  @override
  State<ElectricalPage> createState() => _ElectricalPageState();
}

class _ElectricalPageState extends State<ElectricalPage> {
    final _myBox = Hive.box("myBox");

  _ElectricalPageState();
  var data = RoleUtil.getData();
  String time =  DateFormat("hh:mm a").format(DateTime.now());
  String datum = DateFormat("EEEEE,dd MMMM yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
  var itemWidth = MediaQuery.of(context).size.width * 0.2;
  var itemHeight = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 21, 62),
      body: SingleChildScrollView(
            child: Column(
              children: [
                    //main dio stranice
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.height *0.75,
                      decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 16, 28, 66),
                              border: Border.all(
                                color: const Color.fromARGB(255, 16, 28, 66),
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(18))
                            ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HealthPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Health",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const SecurityPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Security",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey),
                                    ),
                                ),
                                const Text(
                                    "Electricity saving",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white),
                                    ),
                              ],
                            ),
                          ),
                           Expanded(
                               child: Padding(
                                 padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height*0.17
                                 ),
                                 child: GridView.count(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                    primary: false,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: (itemWidth / itemHeight),
                                    children: [
                                      InkWell(
                                        onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => KettlePage(null, null),
                                        ),
                                      );
                                    },
                                        child: Container(
                                          color: const Color.fromARGB(255, 28, 40, 80),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 30
                                                  ),
                                                  child: Icon(
                                                    Icons.soup_kitchen,
                                                    size: 60,
                                                    color: Colors.white,
                                                    ),
                                                ),
                                               
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: MediaQuery.of(context).size.height * 0.02,
                                                        left: 20
                                                      ),
                                                      child: const Text("Kettle",
                                                      style: TextStyle(color: Colors.white, fontSize: 40)),
                                                    ),
                                                  
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => IronPage(null, null),
                                        ),
                                      );
                                    },
                                        child: Container(
                                          color: const Color.fromARGB(255, 28, 40, 80),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 50
                                                  ),
                                                  child: Icon(
                                                    Icons.iron,
                                                    size: 60,
                                                    color: Colors.white,
                                                    ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: MediaQuery.of(context).size.height * 0.12,
                                                        left: 20
                                                      ),
                                                      child: const Text("Iron",
                                                      style: TextStyle(color: Colors.white, fontSize: 40)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                                        
                                    ],  
                                                          ),
                               ),
                           ),
                        ],
                      ),
                    ),
                  ],
                )
        ),
    );
  }
}