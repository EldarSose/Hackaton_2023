import 'package:flutter/material.dart';

import '../devices/health/klima_page.dart';
import '../devices/health/prociscivac_page.dart';
import '../devices/health/usisivac_page.dart';
import 'electrical_page.dart';
import 'security_page.dart';

class HealthPage extends StatelessWidget{
  const HealthPage({super.key});
  
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
                                child:
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "Health",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white),
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
                                          fontSize: 14,
                                          color: Colors.grey),
                                        ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => const ElectricalPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Electricity saving",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey),
                                        ),
                                    ),
                                   
                                  ],
                                ),
                              ),
                           Expanded(
                               child: Padding(
                                 padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
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
                                          builder: (context) => KlimaPage(null, null),
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
                                                    Icons.ac_unit,
                                                    size: 60,
                                                    color: Colors.white,
                                                    ),
                                                ),
                                               
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: MediaQuery.of(context).size.height * 0.02,
                                                        left: 20
                                                      ),
                                                      child: const Text("Temperature",
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
                                          builder: (context) => UsisivacPage(null, null),
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
                                                    Icons.cleaning_services,
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
                                                      child: const Text("Vacuum cleaner",
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
                                          builder: (context) => ProciscivacPage(null, null),
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
                                                    Icons.air,
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
                                                      child: const Text("Air refreshener",
                                                      style: TextStyle(color: Colors.white, fontSize: 40)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 100
                                              ),
                                              child: Icon(
                                                Icons.favorite_sharp,
                                                size: 80,
                                                color: Color.fromARGB(255, 119, 112, 121),
                                                ),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context).size.height * 0.12,
                                                    left: 20
                                                  ),
                                                  child: const Text("iCare",
                                                  style: TextStyle(color: Color.fromARGB(255, 119, 112, 121), fontSize: 60)),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],  
                                                          ),
                               ),
                           ),
                        ],
                      ),
                    ),
                            ],
                          ),
                        ),
    );
}
}