// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackaton_front/UI/forms/components/health.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:hackaton_front/Helper/helper.dart';

import 'components/logo.dart';
import 'components/navigacijski_bar.dart';
import 'components/user_hello.dart';

class ONamaPage extends StatefulWidget {

  const ONamaPage(
    {super.key}
  );

  @override
  State<ONamaPage> createState() => _ONamaPageState();
}

class _ONamaPageState extends State<ONamaPage> {
  final _myBox = Hive.box("myBox");

  _ONamaPageState();
  var data = RoleUtil.getData();
  String time =  DateFormat("hh:mm a").format(DateTime.now());
  String datum = DateFormat("EEEEE,dd MMMM yyyy").format(DateTime.now());
  int selectedIndex = 2;
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 21, 62),
      body: Center(
          child: Column(
            children: [
              //button za dodavanje uredaja
               //logo
                const Logo(),
                //pozdrav za korisnika i trenutno vrijeme
                UserHello(time, datum),
              Row(
                children: [
                  //navigacijski bar
                  Navigation(selectedIndex),   
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
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(60),
                            child: Text("Home Health: Smart Home Automation\n \nSmart home automation is a rapidly growing technology that has the potential to revolutionize the way we live our lives. One of the most promising applications of this technology is in the area of home health. With smart home automation, it is possible to monitor the health and well-being of individuals in their own homes, providing a higher level of care and independence than ever before.\n\nHome health is an area of healthcare that focuses on helping individuals to manage their health conditions and maintain their quality of life from the comfort of their own homes. Smart home automation technology can play a crucial role in achieving these goals. By integrating sensors, cameras, and other smart devices throughout the home, it is possible to monitor vital signs, track medication usage, and provide real-time feedback and alerts to both the individual and their caregivers.\nSmart home automation can even be used to improve the overall safety and security of the home, reducing the risk of falls, accidents, and other hazards.\n\nIn conclusion, home health is a critical area of healthcare that can greatly benefit from the implementation of smart home automation technology. With the ability to monitor vital signs, track medication usage, and provide real-time feedback and alerts, smart home automation can help individuals to maintain their health and independence from the comfort of their own homes.",
                            
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w100,
                                                  color: Color.fromARGB(255, 208, 208, 208),
                                                ),),
                          )
                        ],
                      ),
                    ),
                  ),
                  //osnovni health podaci o osobi
                 Health(bpm, pritisakGornji, pritisakDonji)
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
}
