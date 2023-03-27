import 'package:flutter/material.dart';
import 'package:hackaton_front/Helper/helper.dart';
import 'package:hackaton_front/UI/forms/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../login_page.dart';
import '../onama_page.dart';

class Navigation extends StatelessWidget{
  final _myBox = Hive.box("myBox");
  final int selectedIndex;
  Navigation(
    this.selectedIndex, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Column(
                      children: [
                        //kad je izavbran home page
                        if(selectedIndex == 1)
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
                        //kad je izabran o nama page ili settings
                        if(selectedIndex == 2 || selectedIndex == 3)
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
                            child: const Icon(
                              Icons.home,
                              color: Colors.white),
                          ),
                        ),
                        //kad je izabran home page ili settings
                        if(selectedIndex == 1 || selectedIndex == 3)
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
                        if(selectedIndex == 2)
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
                        // ako je izabran home ili o nama
                        if(selectedIndex == 1 || selectedIndex == 2)
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
                  );
  }
}