import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addStudent(Map<String, dynamic> studentInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Students")
        .doc(id)
        .set(studentInfoMap);
  }

  Stream<QuerySnapshot> getStudentDetails() {
    return FirebaseFirestore.instance.collection("Students").snapshots();
  }

  Future updateAttendance(String attendanceCase, String id) async {
    try {
      await FirebaseFirestore.instance.collection("Students").doc(id).update({
        "Present": attendanceCase == "Present",
        "Absent": attendanceCase == "Absent",
      });
    } catch (e) {
      print("Error updating attendance: $e");
    }
  }

  deleteStudentData(String id)async{
    return await FirebaseFirestore.instance.collection("Students").doc(id).delete();
  }
}
