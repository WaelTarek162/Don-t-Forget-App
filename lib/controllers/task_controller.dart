import 'package:donforget/db/db_helper.dart';
import 'package:donforget/models/task.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {

   final RxList<Task> taskList=<Task>[].obs;

   //show all tasks in DB
   Future<void> get_tasks()async {
     final List<Map<String,dynamic>>tasks=await DBHelper.query();
     taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
     print(Task.fromJson(tasks[0]));
   }

   //complete task in DB
   void mark_completed({required Task task})async {
     await DBHelper.Update(task);
     get_tasks();
   }


   //delete task to DB
  void delete_tasks({required Task task})async {
     await DBHelper.delete(task);
     get_tasks();
   }

   void delete_Alltasks()async {
     await DBHelper.deleteAll();
     get_tasks();
   }

   //insert task to DB
  Future<int> addTask({required Task task}) {

     return DBHelper.insert(task);

  }



}
