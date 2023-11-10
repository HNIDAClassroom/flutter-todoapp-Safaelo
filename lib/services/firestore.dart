import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return tasks.add({
      'taskTitle': task.title.toString(),
      'taskDesc': task.description.toString(),
      'taskCategory': task.category.toString(),
      'completed':task.completed,
      'date': task.date,
    });
  }

 Stream <QuerySnapshot> getTasks()
{
final taskStream= tasks.snapshots();
return taskStream;
}


  Future<void> updateTaskCompletedStatus(String taskId, bool completed) {
    return tasks.doc(taskId).update({'completed': completed});
  }

  Future<void> deleteTask(String taskId) {
  return tasks.doc(taskId).delete();
}

}
