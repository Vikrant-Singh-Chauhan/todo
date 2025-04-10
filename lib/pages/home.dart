import 'package:flutter/material.dart';

import '../services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream ? todoStream ;
  bool today = false, tomorrow = false, next_week = false;
  bool suggest = false;
  TextEditingController task = TextEditingController();

  getOntheLoad() async {
    todoStream =  await DatabaseMethode().getAllDetails(today?"Today":tomorrow?"Tomorrow":"NextWeek");
    setState(() {

    });

  }
  @override
  void initState() {
    getOntheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 50, left: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white60,
            Colors.cyan,
            Colors.brown,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello\nVIKRANT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 39,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// today box ///
                today
                    ? Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          today = true;
                          tomorrow = false;
                          next_week = false;
                          setState(() {});
                        },
                        child: Text(
                          "Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                /// tomorrow box ///
                tomorrow
                    ? Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Tomorrow",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          today = false;
                          tomorrow = true;
                          next_week = false;
                          setState(() {});
                        },
                        child: Text(
                          "Tomorrow",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                /// next_week ///

                next_week
                    ? Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Next Week",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          today = false;
                          tomorrow = false;
                          next_week = true;
                          setState(() {});
                        },
                        child: Text(
                          "Tomorrow",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ///    check box ///
            CheckboxListTile(
              title: Text(
                "Go To The Gym",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              activeColor: Colors.orange,
              value: suggest,
              onChanged: (newValue) {
                setState(() {
                  suggest = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBox();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future openBox() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel)),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Add the Work ToDo",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Add Text"),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2,
                        )),
                    child: TextField(
                      controller: task,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your Task here"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          Map<String, dynamic> userWork = {"Work": task.text};
                          today
                              ? DatabaseMethode().addTodayWork(userWork)
                              : tomorrow
                                  ? DatabaseMethode().addTomorrowWork(userWork)
                                  : DatabaseMethode().addNextWeekWork(userWork);
                          Navigator.pop(context);
                        },
                        child: Text("Done")),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
