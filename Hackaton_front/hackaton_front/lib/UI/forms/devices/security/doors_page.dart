import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/Models/doors.dart';
import 'package:hackaton_front/UI/forms/home_page.dart';
import 'package:hackaton_front/UI/forms/onama_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../../Helper/global_url.dart';
import '../../login_page.dart';

class DoorsPage extends StatefulWidget {
  int? selectedIndex;
  Doors? objekat;
  DoorsPage(this.selectedIndex, this.objekat, {super.key});

  @override
  State<DoorsPage> createState() => _DoorsPageState(selectedIndex, objekat);
}

class _DoorsPageState extends State<DoorsPage> {
    final _myBox = Hive.box("myBox");

  int? selectedIndex;
  Doors? objekat;
  _DoorsPageState(this.selectedIndex, this.objekat);
  var data = RoleUtil.getData();
  String time =  DateFormat("hh:mm a").format(DateTime.now());
  String datum = DateFormat("EEEEE,dd MMMM yyyy").format(DateTime.now());
  String selected = "Health";
  int bpm = 60;
  int pritisakGornji = 120;
  int pritisakDonji = 80;
  bool svic = false;

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
                          child: InkWell(
                            onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                            },
                            child: Container(
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
                        ElevatedButton.icon(onPressed: () {
                          dodajUredaj(context);
                        }, label: const Text("Add new device"), icon: const Icon(Icons.add),),
                         Padding(
                          padding: const EdgeInsets.only(
                            top: 40
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width *0.6,
                            height: MediaQuery.of(context).size.height * 0.4,
                            color: const Color.fromARGB(255, 28, 40, 80),
                            child: Row(
                              children: [
                                const Icon(Icons.door_front_door, size: 150, color: Colors.white),
                                
                                    Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Text(objekat == null ? "Choose doors": objekat!.naziv,
                                      style: const TextStyle(color: Colors.white, fontSize: 15)),
                                    ),
                                   
                                    Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(30),
                                          child: Text("Locked?",
                                          style: TextStyle(color: Colors.white, fontSize: 15)),
                                        
                                ),
                                Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: Text(objekat == null ? "First choose doors" : objekat!.stanje == true ? "Doors are locked" : "Doors are unlocked",
                                          style: const TextStyle(color: Colors.white, fontSize: 15)),
                                        
                                ),
                                if(objekat != null)
                                Switch(
                                  activeColor: Colors.amber,
                                  activeTrackColor: Colors.cyan,
                                  inactiveThumbColor: Colors.blueGrey.shade600,
                                  inactiveTrackColor: Colors.grey.shade400,
                                  splashRadius: 50.0,
                                  value: svic,
                                  // changes the state of the switch
                                  onChanged: (value) => setState(() => svic = value), 
                                ),
                                      ],
                                    ),
                                    
                              ],
                            ),
                          ),
                        ),
                        FutureBuilder<List<Doors>>(
              future: fetch(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                       return Card(
            child: InkWell(
              onTap: () {
                          setState(() {
                          objekat = snapshot.data![index];
                            selectedIndex = index;
                            Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DoorsPage(selectedIndex, objekat),
                                      ),
                                    );
                          });
                        },
              child: ListTile(
                tileColor: Color.fromARGB(255, 200, 198, 213),
                leading: const Icon(Icons.perm_device_information, color: Color(0xfff8a55f)),
                title: Text("Naziv: ${snapshot.data![index].naziv}"),
              ),
            ),
          );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const CircularProgressIndicator();
              }),
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
  TextEditingController nazivController = TextEditingController();
  showDialog(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: const Color.fromARGB(255, 36, 63, 158),
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
                  height: MediaQuery.of(context).size.height / 8,
                  child: TextFormField(
                      controller: nazivController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.short_text),
                        hintText: 'Enter name for device',
                        labelText: 'Name',
                      ),
                      validator: (String? value) {
                        return (value!.isEmpty)
                            ? 'Enter the name for your device.'
                            : null;
                      }),
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
             if (_formKey.currentState!.validate()){
             var building = addDevice(nazivController);

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

addDevice(nazivController) async {
  var data = RoleUtil.getData();
  final response = await http.post(Uri.parse('${GlobalUrl.url}Vrata/Snimi'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': 0,
          'naziv': nazivController.text.toString(),
          'stanje': false,
          "vrijemeZakljucavanja": "2023-03-18T23:39:53.740Z",
          "vrijemeOtkljucavanja": "2023-03-18T23:39:53.740Z",
          "homeId": data["kucaId"],
        }));
    return int.parse(response.body);
    }

getUredajByKategorija(String? kategorija){}

Future<List<Doors>> fetch() async{
  var data = RoleUtil.getData();
  var url = Uri.parse('${GlobalUrl.url}Vrata/GetByHouse?homeId=${data["kucaId"]}');
    final response = await http.get(url);
    
    
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((report) => Doors.fromMap(report)).toList();
    
  }