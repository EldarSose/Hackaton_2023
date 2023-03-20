import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/devices/electricity/iron_page.dart';
import 'package:hackaton_front/UI/forms/devices/electricity/kettle_page.dart';
import 'package:hackaton_front/UI/forms/home_page.dart';
import 'package:hackaton_front/UI/forms/security_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'login_page.dart';
import 'onama_page.dart';

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
  String selected = "Health";
  int bpm = 60;
  int pritisakGornji = 120;
  int pritisakDonji = 80;

   List<String> kategorije =  ["Health", "Security", "Electrical"];
   List<String> uredaji = [];
   String? kategorija;
   String? uredaj;

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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //ime korisnika i pozdrav
                      Column(
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
                      //trenutno vrijeme
                      Column(
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
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Health",
                                  style: TextStyle(
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
                    child: DropdownButton<String>(
                      hint: Text(kategorija ??
                          "Make a selection"),
                      items: <String>["Health", "Security", "Electrical"]
                          .map<DropdownMenuItem<String>>((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          kategorija = value;
                          uredaj = null;
                          getUredajByKategorija(kategorija).then((value) => uredaji = value);
                        });
                      },
                    )
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 30, left: MediaQuery.of(context).size.width *0.2),
                      child:  Container(
                                  child: DropdownButton<String>(
                                    hint: Text(uredaj ??
                                        "Make a selection"),
                                    items: uredaji
                                        .map<DropdownMenuItem<String>>((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        uredaj = value;
                                      });
                                    },
                                  ),
                                )
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


Future<List<String>> getCategories() async {
  List<String> lista = await ["Health", "Security", "Electrical"];
  return await lista;
}

addDevice(String? kategorija, String? uredaj){}

Future<List<String>> getUredajByKategorija(String? kategorija) async{
  List<String> lista = [];
  if(kategorija == "Health"){
    lista.add("Air conditioner");
    lista.add("Vacuum cleaner");
    lista.add("Air freshener");
  } else if(kategorija == "Security"){
    lista.add("Doors");
    lista.add("Windows");
  }
  else if(kategorija == "Electrical"){
    lista.add("Kettle");
    lista.add("Iron");
  }
  return lista;
}