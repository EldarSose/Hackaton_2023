import 'package:flutter/material.dart';

class Health extends StatelessWidget{
  final int bpm;
  final int pritisakGornji;
  final int pritisakDonji;
  const Health(this.bpm, this.pritisakGornji, this.pritisakDonji, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                                      children: const [
                                        Text("Fall sensor", style: TextStyle(fontSize: 19, color: Color.fromARGB(255, 170, 139, 26)),),
                                        Text("False", style: TextStyle(fontSize: 19, color: Colors.white),),
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
                                      children: const [
                                        Text("Smoke detector", style: TextStyle(fontSize: 19, color: Color.fromARGB(255, 170, 139, 26)),),
                                        Text("False", style: TextStyle(fontSize: 19, color: Colors.white),),
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
    );
  }
}