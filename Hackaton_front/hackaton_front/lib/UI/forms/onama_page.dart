import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'login_page.dart';

class ONamaPage extends StatefulWidget {
  const ONamaPage({super.key});

  @override
  State<ONamaPage> createState() => _ONamaPageState();
}

class _ONamaPageState extends State<ONamaPage> {
    final _myBox = Hive.box("myBox");

  _ONamaPageState();
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
                        size: 40,
                        color: Color.fromARGB(255, 119, 112, 121),
                        ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03,
                            left: 20
                          ),
                          child: const Text("ICare",
                          style: TextStyle(color: Color.fromARGB(255, 119, 112, 121), fontSize: 30)),
                        )
                      ],
                    )
                  ],
                ),
                //pozdrav za korisnika i trenutno vrijeme
                Container(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //ime korisnika i pozdrav
                      Container(
                        child: Column(
                          children:  [
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 8
                          ),
                          child: Container(
                          
                            child: InkWell(
                              onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                            },
                              child: const Icon(
                                Icons.home,
                                color: Colors.white),
                            ),
                          ),
                          
                        ),
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
                                Icons.device_unknown,
                                color: Colors.white),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 8
                          ),
                          child: InkWell(
                            child: const Icon(
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.all(60),
                              child: Text("Home Health: Smart Home Automation\n \nSmart home automation is a rapidly growing technology that has the potential to revolutionize the way we live our lives. One of the most promising applications of this technology is in the area of home health. With smart home automation, it is possible to monitor the health and well-being of individuals in their own homes, providing a higher level of care and independence than ever before.\n\nHome health is an area of healthcare that focuses on helping individuals to manage their health conditions and maintain their quality of life from the comfort of their own homes. Smart home automation technology can play a crucial role in achieving these goals. By integrating sensors, cameras, and other smart devices throughout the home, it is possible to monitor vital signs, track medication usage, and provide real-time feedback and alerts to both the individual and their caregivers.\nSmart home automation can even be used to improve the overall safety and security of the home, reducing the risk of falls, accidents, and other hazards.\n\nIn conclusion, home health is a critical area of healthcare that can greatly benefit from the implementation of smart home automation technology. With the ability to monitor vital signs, track medication usage, and provide real-time feedback and alerts, smart home automation can help individuals to maintain their health and independence from the comfort of their own homes.",
                              
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w100,
                                                    color: Color.fromARGB(255, 208, 208, 208),
                                                  ),),
                            ),
                            
                          )
                        ],
                      ),
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