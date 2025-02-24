import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:student_attendance_app/services/database.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Icon(Icons.arrow_back_ios),
                ),
                SizedBox(width: 30.0),
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
            SizedBox(height: 20),
            Text(
              "Student Name",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Student Name",
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Student RollNo.",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: rollNoController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Student RollNo.",
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Student Age",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Student Age",
                ),
              ),
            ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () async {
                if (nameController.text != "" &&
                    rollNoController.text != "" &&
                    ageController.text != "") {
                  String addID = randomAlphaNumeric(10);
                  Map<String, dynamic> studentInfoMap = {
                    "Name": nameController.text,
                    "RollNo": rollNoController.text,
                    "Age": ageController.text,
                    "Present": false,
                    "Absent": false,
                  };
                  await DatabaseMethods()
                      .addStudent(studentInfoMap, addID)
                      .then((value) {
                        nameController.text = "";
                        rollNoController.text = "";
                        ageController.text = "";
                        Get.snackbar(
                          "Success",
                          "Student Data Uploaded",
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          borderRadius: 10,
                          margin: EdgeInsets.all(20),
                          snackStyle: SnackStyle.FLOATING,
                        );
                      });
                }
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
