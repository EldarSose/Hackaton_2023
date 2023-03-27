import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/components/health.dart';
import 'package:hackaton_front/UI/forms/components/logo.dart';
import 'package:hackaton_front/UI/forms/components/navigacijski_bar.dart';
import 'package:hackaton_front/UI/forms/components/user_hello.dart';
import 'package:hackaton_front/UI/forms/views/health_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';


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
  int bpm = 60;
  int pritisakGornji = 120;
  int pritisakDonji = 80;
  int selectedIndex = 1;

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
              //logo
                const Logo(),
                //pozdrav za korisnika i trenutno vrijeme
                UserHello(time, datum),
                  //navigacijski bar
              Row(
                children: [
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
                    child: const MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: HealthPage(),
                    ),
                  ),
                  //osnovni health podaci o osobi
                  Health(bpm, pritisakGornji, pritisakDonji),
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
