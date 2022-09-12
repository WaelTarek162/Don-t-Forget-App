class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({this.id, this.title, this.note, this.isCompleted, this.date,
      this.startTime, this.endTime, this.color, this.remind, this.repeat});

  Map<String,dynamic>toJson(Task task){
    return {
    'id':task.id,
    'title':task.title,
    'note':task.note,
    'isCompleted':task.isCompleted,
    'date':task.date,
    'startTime':task.startTime,
    'endTime':task.endTime,
    'color':task.color,
    'remind':task.remind,
    'repeat':task.repeat

    };
  }

  Task.fromJson(Map<String,dynamic> json){
      id=json['id'];
      title=json['title'];
      note=json['note'];
      isCompleted=json['isCompleted'];
      date=json['date'];
      startTime=json['startTime'];
      endTime=json['endTime'];
      color=json['color'];
      remind=json['remind'];
      repeat=json['repeat'];


  }

}
