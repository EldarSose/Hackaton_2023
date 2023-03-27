
import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/devices/security/doors_page.dart';
import 'package:hackaton_front/UI/forms/devices/security/windows_page.dart';
import 'package:hackaton_front/UI/forms/views/electrical_page.dart';
import 'package:hackaton_front/UI/forms/views/health_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';


class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
    final _myBox = Hive.box("myBox");

  _SecurityPageState();
  var data = RoleUtil.getData();
  String time =  DateFormat("hh:mm a").format(DateTime.now());
  String datum = DateFormat("EEEEE,dd MMMM yyyy").format(DateTime.now());
  String selected = "Health";
  int bpm = 60;
  int pritisakGornji = 120;
  int pritisakDonji = 80;


  @override
  Widget build(BuildContext context) {
  var itemWidth = MediaQuery.of(context).size.width * 0.2;
  var itemHeight = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 21, 62),
      body: SingleChildScrollView(
            child: Column(
              children: [
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
                                const Text(
                                  "Security",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white),
                                  ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ElectricalPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Electricity saving",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey),
                                    ),
                                ),
                              ],
                            ),
                          ),
                           Expanded(
                               child: Padding(
                                 padding:  EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height*0.17,
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
                                          builder: (context) => DoorsPage(null, null),
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
                                                    Icons.door_front_door,
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
                                                      child: const Text("Doors",
                                                      style: TextStyle(color: Colors.white, fontSize: 40)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => WindowPage(null, null),
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
                                                    Icons.window,
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
                                                      child: const Text("Windows",
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