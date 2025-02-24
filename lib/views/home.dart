import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_attendance_app/services/database.dart';
import 'package:student_attendance_app/views/add_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    getontheload();
    super.initState();
  }

  getontheload() async{
    studentStream = DatabaseMethods().getStudentDetails();
    setState(() {

    });
  }

  Stream? studentStream;

  Widget showStudentsList() {
    return StreamBuilder(
      stream: studentStream,
      builder: (context, AsyncSnapshot snapshots) {
        return snapshots.hasData
            ? ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: snapshots.data.docs.length,
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot ds = snapshots.data.docs[index];
            return Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Student Name : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          ds["Name"],
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: ()async{
                            await DatabaseMethods().deleteStudentData(ds.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.delete, color: Colors.black, size: 25,),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          "Student RollNo. : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          ds["RollNo"],
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          "Student Age : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          ds["Age"],
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          "Attendance : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(width: 10),

                        // Present Button (P)
                        GestureDetector(
                          onTap: () => DatabaseMethods().updateAttendance("Present", ds.id),
                          child: Container(
                            width: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ds["Present"] == true ? Colors.green : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Text(
                                "P",
                                style: TextStyle(
                                  color: ds["Present"] == true ? Colors.white : Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Absent Button (A)
                        GestureDetector(
                          onTap: () => DatabaseMethods().updateAttendance("Absent", ds.id),
                          child: Container(
                            width: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ds["Absent"] == true ? Colors.red : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(),
                            ),
                            child: Center(
                              child: Text(
                                "A",
                                style: TextStyle(
                                  color: ds["Absent"] == true ? Colors.white : Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }, separatorBuilder: (context, index) => SizedBox(height: 10),
        ): Container();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => Get.to(AddStudent()),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Student ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  "Attendance",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(child: showStudentsList()),
          ],
        ),
      ),
    );
  }
}
