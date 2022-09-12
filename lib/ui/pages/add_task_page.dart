import 'package:donforget/controllers/task_controller.dart';
import 'package:donforget/models/task.dart';
import 'package:donforget/ui/theme.dart';
import 'package:donforget/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  String _selected_rebeat = 'None';
  int _selsctedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: heading_style,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter Title here!',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note here!',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => _getDateFromUser(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStart: true),
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStart: false),
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                              (int val) =>
                              DropdownMenuItem<String>(
                                  value: val.toString(),
                                  child: Text(
                                    '$val',
                                    style: const TextStyle(color: Colors.white),
                                  )))
                          .toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          _selectedRemind = int.parse(newVal!);
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: Sub_title_style,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              InputField(
                title: 'Rebeat',
                hint: _selected_rebeat,
                widget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                              (String val) =>
                              DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(
                                    '$val',
                                    style: const TextStyle(color: Colors.white),
                                  )))
                          .toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          _selected_rebeat = newVal!;
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: Sub_title_style,
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ColorPalate(),
                  MyButton(
                      label: 'Create Task',
                      onTab: () {
                        _validateDate();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() =>
      AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: primaryClr,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'), radius: 20),
          SizedBox(
            width: 20,
          )
        ],
      );

  Column _ColorPalate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color'),
        const SizedBox(
          height: 10,
        ),
        Wrap(
            children: List.generate(
              3,
                  (index) =>
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setState(() {
                          _selsctedColor = index;
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        child: index == _selsctedColor
                            ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                            : null,
                        backgroundColor: index == 0
                            ? primaryClr
                            : index == 1
                            ? pinkClr
                            : orangeClr,
                        radius: 14,
                      ),
                    ),
                  ),
            )),
      ],
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasktoDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar('required', 'please fill all data!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Get.isDarkMode?Colors.black:Colors.white,
          colorText: Colors.pink,
          icon: const Icon(
            Icons.label_important,
            color: Colors.red,
          ));
    } else {
      print('###################');
    }
  }

  _addTasktoDB() async {
    int value = await _taskController.addTask(
        task: Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            color: _selsctedColor,
            remind: _selectedRemind,
            repeat: _selected_rebeat));
    print(value);
  }

  _getDateFromUser() async {
    DateTime? Selected = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if (Selected != null) {
      setState(() {
        _selectedDate = Selected!;
      });
    } else {
      print('it is null');
    }
  }

  _getTimeFromUser({required bool isStart}) async {
    TimeOfDay? Selected = (await showTimePicker(
      context: context,
      initialTime: isStart
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),)
    );

        String _formattedTime = Selected!.format(context);
    if (isStart==true){
      setState(() => _startTime = _formattedTime);}
   else if (isStart==false)
     { setState(() => _endTime = _formattedTime);}
    else
     { print('canceld');}


  }
}
