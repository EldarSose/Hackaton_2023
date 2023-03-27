import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/Models/window.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../../Helper/global_url.dart';

class WindowPage extends StatefulWidget {
  int? selectedIndex;
  Window? objekat;
  WindowPage(this.selectedIndex, this.objekat, {super.key});

  @override
  State<WindowPage> createState() => _WindowPageState(selectedIndex, objekat);
}

class _WindowPageState extends State<WindowPage> {
    final _myBox = Hive.box("myBox");

  int? selectedIndex;
  Window? objekat;
  _WindowPageState(this.selectedIndex, this.objekat);
  var data = RoleUtil.getData();
  String time =  DateFormat("hh:mm a").format(DateTime.now());
  String datum = DateFormat("EEEEE,dd MMMM yyyy").format(DateTime.now());
  int selected = 1;
  bool svic = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        Row(
                          children: [
                             Padding(
                               padding: const EdgeInsets.only(
                                left: 20,
                               ),
                               child: InkWell(
                                                         onTap: () {
                                      Navigator.of(context).pop();
                                                         },
                                                         child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white),
                                                       ),
                             ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.23,
                              ),
                              child: ElevatedButton.icon(onPressed: () {
                                dodajUredaj(context);
                              }, label: const Text("Add new device"), icon: const Icon(Icons.add),),
                            ),
                          ],
                        ),
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
                                const Icon(Icons.window, size: 150, color: Colors.white),
                                
                                    Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Text(objekat == null ? "Choose window": objekat!.naziv,
                                      style: const TextStyle(color: Colors.white, fontSize: 15)),
                                    ),
                                    
                                    Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(30),
                                          child: Text("Opened?",
                                          style: TextStyle(color: Colors.white, fontSize: 15)),
                                        
                                ),
                                Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: Text(objekat == null ? "First choose window" : objekat!.otvoren == true ? "Window is opened" : "Window is closed",
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
                        FutureBuilder<List<Window>>(
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
                            Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => WindowPage(selectedIndex, objekat),
                                      ),
                                    );
                          });
                        },
              child: ListTile(
                tileColor: const Color.fromARGB(255, 200, 198, 213),
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
                ],
              )
    );
  }
dodajUredaj(BuildContext context){
  final formKey = GlobalKey<FormState>();
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
          key: formKey,
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
             if (formKey.currentState!.validate()){
                addDevice(nazivController);
            }
          }
        ),
        ],
    )
  )
);
}
}

addDevice(nazivController) async {
  var data = RoleUtil.getData();
  final response = await http.post(Uri.parse('${GlobalUrl.url}Prozori/Snimi'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': 0,
          'naziv': nazivController.text.toString(),
          "otvoren": false,
          "homeId": data["kucaId"],
        }));
    return int.parse(response.body);
    }

Future<List<Window>> fetch() async{
  var data = RoleUtil.getData();
  var url = Uri.parse('${GlobalUrl.url}Prozori/GetByHouse?homeId=${data["kucaId"]}');
    final response = await http.get(url);
    
    
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((report) => Window.fromMap(report)).toList();
    
  }