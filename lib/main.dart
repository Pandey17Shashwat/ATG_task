import './Lessons.dart';
import './Programs.dart';
import './programModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'LessonsModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String link = "https://632017e19f82827dcf24a655.mockapi.io/api/programs";
  String link1 = "https://632017e19f82827dcf24a655.mockapi.io/api/lessons";
  List<Programs> allData = [];
  List<LessonsForYou> allDataLesson = [];
  late LessonsModel lessonModel;
  late ProgramModel model;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoading = false;
  bool isLessonLoading = false;
  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(Uri.parse(link));
      print("Status code is ${responce.statusCode}");
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        for (var i in data["items"]) {
          model = ProgramModel(
            i["name"],
            i["category"],
            i["lesson"],
          );
          setState(() {
            allData.add(Programs(model.name, model.category, model.lesson));
          });
        }
        setState(() {
          isLoading = false;
        });
      }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print("the problem is $e");
        showToast("Somthing was wrong!");
      }

    try {
      setState(() {
        isLessonLoading = true;
      });
      var responce = await http.get(Uri.parse(link1));
      print("Status code is ${responce.statusCode}");
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        for (var i in data["items"]) {
          lessonModel = LessonsModel(
            i["name"],
            i["category"],
            i["duration"],
            i["locked"]
          );
          setState(() {
            allDataLesson.add(LessonsForYou(lessonModel.name, lessonModel.category, lessonModel.duration, lessonModel.lock));
          });
        }
        setState(() {
          isLessonLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLessonLoading = false;
      });
      print("the problem is $e");
      showToast("Somthing was wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 244, 245),
        actions: const [
          Icon(
            Icons.square,
            color: Colors.grey,
          ),
          Icon(
            Icons.circle,
            color: Colors.grey,
          ),
          Icon(
            Icons.pentagon,
            color: Colors.grey,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 56,
            width: 360,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 0, 25),
                  child: const Icon(
                    Icons.chat,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(255, 20, 0, 25),
                  child: const Icon(
                    Icons.chat_bubble_rounded,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(11, 20, 0, 25),
                  child: const Icon(
                    Icons.notification_important,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              // height: 1,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: const Text(
                'Hello, Priya!',
                style: TextStyle(
                    fontFamily: 'Lora',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(16, 5, 0, 0),
            child: const Text(
              'What do you wanna learn today?',
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Size * 0.08, right: Size * 0.02),
                        width: Size * 0.4,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color.fromARGB(255, 15, 138, 239),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.bookmark_add,
                              color: Color.fromARGB(255, 15, 138, 239),
                            ),
                            Text(
                              'Programs',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 15, 138, 239),
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Size * 0.02, right: Size * 0.08),
                        width: Size * 0.4,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color.fromARGB(255, 15, 138, 239))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.question_mark,
                              color: Colors.blue,
                            ),
                            Text(
                              'Get help',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 15, 138, 239),
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: Size * 0.08, right: Size * 0.02),
                        width: Size * 0.4,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color.fromARGB(255, 15, 138, 239))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.book,
                              color: Color.fromARGB(255, 15, 138, 239),
                            ),
                            Text(
                              'learn',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 15, 138, 239),
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Size * 0.02, right: Size * 0.08),
                        width: Size * 0.4,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Color.fromARGB(255, 15, 138, 239))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.vertical_align_top_rounded,
                              color: Color.fromARGB(255, 15, 138, 239),
                            ),
                            Text(
                              'DD tracker',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 15, 138, 239),
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            child: Row(children: [
              SizedBox(
                width: Size * 0.04,
              ),
              SizedBox(
                width: Size * 0.4,
                child: const Text(
                  'Programs for you',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lora',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                width: Size * 0.33,
              ),
              const Text('View all'),
              const Icon(
                Icons.arrow_right_outlined,
                color: Colors.grey,
              )
            ]),
          ),

          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              child: Row(children: allData)),
          const SizedBox(
            height: 80,
          ),
          Container(
            child: Row(children: [
              SizedBox(
                width: Size * 0.04,
              ),
              SizedBox(
                width: Size * 0.4,
                child: const Text(
                  'Events and Experiences',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lora',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                width: Size * 0.33,
              ),
              const Text('View all'),
              const Icon(
                Icons.arrow_right_outlined,
                color: Colors.grey,
              )
            ]),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Column(children: [
                      Image.asset('assets/photo2.png'),
                      const SizedBox(height: 4),
                      const Text(
                        'BABYCARE',
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      const Text('Understanding of human',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text('behaviour',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('13 Feb, Sunday',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                          const SizedBox(width: 15),
                          Container(
                            width: 60,
                            height: 20,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: const Center(
                                child: Text(
                              'Book',
                              style: TextStyle(
                                fontFamily: 'inter',
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          )
                        ],
                      ),
                    ]),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Column(children: [
                      Image.asset('assets/photo2.png'),
                      const SizedBox(height: 4),
                      const Text(
                        'BABYCARE',
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      const Text('Understanding of human',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text('behaviour',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('13 Feb, Sunday',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                          const SizedBox(width: 15),
                          Container(
                            width: 60,
                            height: 20,
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: const Center(
                                child: Text(
                              'Book',
                              style: TextStyle(
                                fontFamily: 'inter',
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          )
                        ],
                      ),
                    ]),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Column(children: [
                      Image.asset('assets/photo2.png'),
                      const SizedBox(height: 4),
                      const Text(
                        'BABYCARE',
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      const Text('Understanding of human',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text('behaviour',
                          style: TextStyle(
                              fontFamily: 'inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('13 Feb, Sunday',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                          const SizedBox(width: 15),
                          Container(
                            width: 60,
                            height: 20,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: const Center(
                                child: Text(
                              'Book',
                              style: TextStyle(
                                fontFamily: 'inter',
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          )
                        ],
                      ),
                    ]),
                  ),
                ],
              )),

          // lessons for you

          const SizedBox(
            height: 80,
          ),

          Container(
            child: Row(children: [
              SizedBox(
                width: Size * 0.04,
              ),
              SizedBox(
                width: Size * 0.4,
                child: const Text(
                  'Lessons for you',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lora',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                width: Size * 0.33,
              ),
              const Text('View all'),
              const Icon(
                Icons.arrow_right_outlined,
                color: Colors.grey,
              )
            ]),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              child: Row(
                //alldataLesson
                children: allDataLesson 
                //alldataLesson here 
              )),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Learn',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.hub),
              label: 'Hub',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf_outlined),
              label: 'Profile',
              backgroundColor: Colors.blue),
        ],
        // currentIndex: _selectedIndex,
        // selectedItemColor: Colors.blue
        // onTap: _onItemTapped,
      ),
    );
  }
}

showToast(String title) {
  return Fluttertoast.showToast(
      msg: "${title}",
      //toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}
