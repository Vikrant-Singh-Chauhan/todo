import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethode {
  Future addTodayWork(Map<String, dynamic> userTodayMap) async {
    return await FirebaseFirestore.instance
        .collection("Today")
        .doc()
        .set(userTodayMap);
  }

  Future addTomorrowWork(Map<String, dynamic> userTodayMap) async {
    return await FirebaseFirestore.instance
        .collection("Tomorrow")
        .doc()
        .set(userTodayMap);
  }

  Future addNextWeekWork(Map<String, dynamic> userTodayMap) async {
    return await FirebaseFirestore.instance
        .collection("NextWeek")
        .doc()
        .set(userTodayMap);
  }

  // Future<Stream<QuerySnapshot>> getAllDetails( String day) async {
  //   return await FirebaseFirestore.instance.collection("day").snapshots();
  // }
  Future<Stream<QuerySnapshot>> getAllDetails(String day) async {
    return FirebaseFirestore.instance.collection(day).snapshots();
  }

  // updateTicked(String id, String day) async {
  //   return await FirebaseFirestore.instance
  //       .collection("day")
  //       .doc(id)
  //       .update({"Yes": true});
  // }
  Future updateTicked(String id, String day, bool newValue) async {
    return await FirebaseFirestore.instance
        .collection(day) // Use the actual variable, not "day" string
        .doc(id)
        .update({"Yes": newValue});
  }

}
