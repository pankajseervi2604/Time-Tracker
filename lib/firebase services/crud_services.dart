import 'package:cloud_firestore/cloud_firestore.dart';

class CrudServices {
  // create collection reference
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  // create a new task
  Future addTask(String taskName,int hours,int minutes){
    return tasks.add({
      'task_name' : taskName,
      'duration_hours' : hours,
      'duration_minutes' : minutes,
    });
  }
  // read new task 
  Stream<QuerySnapshot> getTaskData(){
    return tasks.snapshots();
  }
  
}