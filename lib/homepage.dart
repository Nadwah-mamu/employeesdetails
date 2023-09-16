import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic> getEmpDetails() async {
    try {
      final url = 'https://dummy.restapiexample.com/api/v1/employees';
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        final body = jsonDecode(response.body);
        if (body["data"][0].isNotEmpty) {
          return body;
        }
        setState(() {

        });
      }
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getEmpDetails(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        "Employee Profiles",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data["data"].length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    EdgeInsets.only(top: 10, right: 5, left: 5),
                                decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? Colors.yellow.shade200
                                        : index % 3 == 0 || index %6==0
                                            ? Colors.pink.shade100
                                            : Colors.blue.shade100,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: Icon(
                                          Icons.person,
                                          size: 35,
                                        ),
                                        height: 70,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 7),
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data["data"][index]
                                                ["employee_name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Age : ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                snapshot.data["data"][index]
                                                        ["employee_age"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "Salary : ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                snapshot.data["data"][index]
                                                        ["employee_salary"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              } else {
                return Text("Something went wrong");
              }
            }),
      ),
    );
  }
}
