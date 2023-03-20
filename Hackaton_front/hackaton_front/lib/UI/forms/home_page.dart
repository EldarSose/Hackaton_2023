import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/devices/health/prociscivac_page.dart';
import 'package:hackaton_front/UI/forms/devices/health/usisivac_page.dart';
import 'package:hackaton_front/UI/forms/electrical_page.dart';
import 'package:hackaton_front/UI/forms/onama_page.dart';
import 'package:hackaton_front/UI/forms/security_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'devices/health/klima_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final _myBox = Hive.box("myBox");

  _HomePageState();
  var data = RoleUtil.getData();
  String time =  DateFormat("hh:mm a").format(DateTime.now());
  String datum = DateFormat("EEEEE,dd MMMM yyyy").format(DateTime.now());
  String selected = "Health";
  int bpm = 60;
  int pritisakGornji = 120;
  int pritisakDonji = 80;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1),
   (Timer t) => getRandNumber());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  var itemWidth = MediaQuery.of(context).size.width * 0.2;
  var itemHeight = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 21, 62),
      body: Center(
          child: Column(
            children: [
              //button za dodavanje uredaja
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: 100
                      ),
                      child: const Icon(
                        Icons.favorite_sharp,
                        size: 50,
                        color: Color.fromARGB(255, 201, 194, 202),
                        ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                            left: 20
                          ),
                          child: const Text("iCare",
                          style: TextStyle(color: Color.fromARGB(255, 201, 194, 202), fontSize: 40)),
                        )
                      ],
                    )
                  ],
                ),
                //pozdrav za korisnika i trenutno vrijeme
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //ime korisnika i pozdrav
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Text(
                                "Hello ${data["ime"]} ${data["prezime"]}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  ),
                                ),
                            ),
                            const Text(
                                "Have a nice day",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                            )
                          ],
                        ),
                      ),
                      //trenutno vrijeme
                      Container(
                        child: Column(
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              time,
                              style: const TextStyle(color: Colors.white,),
                            ),
                          ),
                          Text(
                            datum,
                            style: const TextStyle(color: Colors.white,),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  //navigacijski bar
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 8
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 108, 41, 251),
                            border: Border.all(
                              color: const Color.fromARGB(255, 108, 41, 251),
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(7))
                          ),
                            child: const Icon(
                              Icons.home,
                              color: Colors.white),
                          ),
                          
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 8
                          ),
                          child: InkWell(
                            onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const ONamaPage(),
                                      ),
                                    );
                            },
                            child: const Icon(
                              Icons.device_unknown,
                              color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 8
                          ),
                          child: const InkWell(
                            child: Icon(
                              Icons.settings,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 8
                          ),
                          child: InkWell(
                            onTap: () {
                _myBox.clear();
                RoleUtil.deleteDataFromBox();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginForm()));
              },
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white),
                          ),
                        )
                      ]
                    ),
                  ),
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
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Row(
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
                                      color: Colors.grey),
                                    ),
                                ),
                              ],
                            ),
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
                                        builder: (context) => const KlimaPage(null, null),
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
                                    Container(
                                      child: Center(
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
                                      ),
                                    )
                                  ],  
                                                        ),
                             ),
                         ),
                      ],
                    ),
                  ),
                  //osnovni health podaci o osobi
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.025,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height *0.75,
                      decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 16, 28, 66),
                            border: Border.all(
                              color: const Color.fromARGB(255, 16, 28, 66),
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(18))
                          ),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                right: 40,
                                top: 40),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(color: Colors.white, width: 1))),
                                child: Row(
                                  children: [
                                    const Icon(Icons.monitor_heart, size: 60, color: Color.fromARGB(255,180,0,0)),
                                    Column(
                                      children: [
                                        const Text("Blood pressure", style: TextStyle(fontSize: 19, color: Color.fromARGB(255,180,0,0)),),
                                        Text("$pritisakGornji/$pritisakDonji mmHg", style: const TextStyle(fontSize: 19, color: Colors.white),),
                                      ],
                                    )
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                right: 40,
                                top: 40),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(color: Colors.white, width: 1))),
                                child: Row(
                                  children: [
                                    const Icon(Icons.trending_up, size: 60, color: Color.fromARGB(255,180,0,0)),
                                    Column(
                                      children: [
                                        const Text("Heart rate", style: TextStyle(fontSize: 19, color: Color.fromARGB(255,180,0,0)),),
                                        Text("$bpm bPm", style: const TextStyle(fontSize: 19, color: Colors.white),),
                                      ],
                                    )
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                right: 40,
                                top: 80),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(color: Colors.white, width: 1))),
                                child: Row(
                                  children: [
                                    const Icon(Icons.personal_injury, size: 60, color: Color.fromARGB(255, 170, 139, 26)),
                                    Column(
                                      children: [
                                        const Text("Fall sensor", style: TextStyle(fontSize: 19, color: Color.fromARGB(255, 170, 139, 26)),),
                                        const Text("False", style: TextStyle(fontSize: 19, color: Colors.white),),
                                      ],
                                    )
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                right: 40,
                                top: 40),
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(color: Colors.white, width: 1))),
                                child: Row(
                                  children: [
                                    const Icon(Icons.smoke_free, size: 60, color: Color.fromARGB(255, 170, 139, 26)),
                                    Column(
                                      children: [
                                        const Text("Smoke detector", style: TextStyle(fontSize: 19, color: Color.fromARGB(255, 170, 139, 26)),),
                                        const Text("False", style: TextStyle(fontSize: 19, color: Colors.white),),
                                      ],
                                    )
                                ]),
                              ),
                            ),
                        ],)
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
  getRandNumber(){
    Random random = Random();
    setState(() {
      bpm = random.nextInt(30) +60 ;
      pritisakGornji = random.nextInt(50) + 100;
      pritisakDonji = random.nextInt(40) + 60;
    });
  }
dodajUredaj(BuildContext context){
  final _formKey = GlobalKey<FormState>();
  String? kategorija;
  String? uredaj;
  showDialog(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: const Color.fromARGB(255, 10, 21, 62),
    title: const Text("Add new device",
    style: TextStyle(color: Colors.white),),
    content: Column(
        children: [
          SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width *0.4,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: MediaQuery.of(context).size.width / 4),
                    child: FutureBuilder(
                      future: getCategories(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? Container(
                                child: DropdownButton<String>(
                                  hint: Text(kategorija ??
                                      "Make a selection"),
                                  items: snapshot.data
                                      .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.countryName,
                                      child: Text(item.countryName),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      kategorija = value;
                                      uredaj = null;
                                    });
                                  },
                                ),
                              )
                            : Container(
                                child: const Center(
                                  child: Text('Loading...'),
                                ),
                              );
                      },
                    ),
                  ),
                ),
                if (kategorija != null)
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30, left: MediaQuery.of(context).size.width *0.2),
                      child: FutureBuilder(
                        future: getUredajByKategorija(kategorija),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? Container(
                                  child: DropdownButton<String>(
                                    hint: Text(uredaj ??
                                        "Make a selection"),
                                    items: snapshot.data
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item.countyName,
                                        child: Text(item.countyName),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        uredaj = value;
                                      });
                                    },
                                  ),
                                )
                              : Container(
                                  child: const Center(
                                    child: Text('Loading...'),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        )),
          TextButton(
          child: const Text(
            "SELECT",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          
          onPressed: () { 
            Navigator.of(context).pop();
             if (_formKey.currentState!.validate() &&
                kategorija != null &&
                uredaj != null){
             var building = addDevice(kategorija, uredaj);

            }
          }
        ),
        ],
    )
  )
);
}
}


getCategories(){}

addDevice(String? kategorija, String? uredaj){}

getUredajByKategorija(String? kategorija){}