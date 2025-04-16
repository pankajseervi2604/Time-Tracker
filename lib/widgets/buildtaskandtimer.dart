import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:time_tracker/firebase%20services/crud_services.dart';

class Buildtaskandtimer extends StatefulWidget {
  const Buildtaskandtimer({super.key});

  @override
  State<Buildtaskandtimer> createState() => _BuildtaskandtimerState();
}

class _BuildtaskandtimerState extends State<Buildtaskandtimer> {
  final _taskName = TextEditingController();
  bool _isRunning = false;

  final service = CrudServices();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  Widget build(BuildContext context) {
    return buildTaskAndTimer(context, _taskName);
  }

  Widget buildTaskAndTimer(
      BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        Container(
          height: 500,
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.deepPurple,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tasks",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    int selectedHour = 0;
                    int selectedMinute = 0;
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (context) {
                        // 'statefullbuilder' to access the state in bottom sheet
                        return StatefulBuilder(
                          builder: (context, setState) => Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                              left: 20,
                              right: 20,
                              top: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New Task',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  controller: controller,
                                  undoController: UndoHistoryController(
                                    value: UndoHistoryValue(
                                      canRedo: true,
                                      canUndo: true,
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Add new task",
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 10,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Set Duration",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Hours"),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      NumberPicker(
                                                        minValue: 0,
                                                        maxValue: 12,
                                                        zeroPad: true,
                                                        infiniteLoop: false,
                                                        itemHeight: 40,
                                                        itemWidth: 80,
                                                        value: selectedHour,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedHour =
                                                                value;
                                                          });
                                                        },
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                        selectedTextStyle:
                                                            TextStyle(
                                                          color:
                                                              Colors.deepPurple,
                                                          fontSize: 24,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            top: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text("Minutes"),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      NumberPicker(
                                                        haptics: true,
                                                        minValue: 0,
                                                        maxValue: 60,
                                                        value: selectedMinute,
                                                        zeroPad: true,
                                                        infiniteLoop: false,
                                                        itemHeight: 40,
                                                        itemWidth: 80,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedMinute =
                                                                value;
                                                          });
                                                        },
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                        ),
                                                        selectedTextStyle:
                                                            TextStyle(
                                                          color:
                                                              Colors.deepPurple,
                                                          fontSize: 24,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            top: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  onPressed: () {
                                    // adding task
                                    service.addTask(_taskName.text.trim(),
                                        selectedHour, selectedMinute);
                                    Navigator.pop(context);
                                    _taskName.clear();
                                  },
                                  child: Text(
                                    "Add task",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  label: Text(
                    "Add new task",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Divider(),
                // todo : added task data should be displayed below
                StreamBuilder(
                  stream: service.getTaskData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final taskList = snapshot.data!.docs;
                      return SizedBox(
                        height: 370,
                        child: ListView.builder(
                          itemCount: taskList.length,
                          itemBuilder: (context, index) {
                            // get individual doc
                            DocumentSnapshot document = taskList[index];
                            String docID = document.id;

                            // get task from each doc
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            String taskName = data['task_name'];
                            int timeInHour = data['duration_hours'];
                            int timeInMinutes = data['duration_minutes'];
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.deepPurple),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    taskName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${timeInHour.toString().padLeft(2, '0')} : ${timeInMinutes.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              splashColor: Colors.grey[50],
                              onTap: () {},
                            );
                          },
                        ),
                      );
                    } else {
                      return Text("No Tasks found, try to create one");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          width: 400,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 60,
                              width: 180,
                              child: Card(
                                elevation: 0.5,
                                shadowColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Center(
                                    // creating stream builder for stream of time
                                    child: StreamBuilder<int>(
                                      // calling the stream method for working proces
                                      stream: _stopWatchTimer.rawTime,
                                      // initialize the data of stopwatch
                                      initialData:
                                          _stopWatchTimer.rawTime.value,
                                      builder: (context, snapshot) {
                                        final displayTime =
                                            StopWatchTimer.getDisplayTime(
                                                snapshot.data!);
                                        return Text(
                                          displayTime,
                                          style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _stopWatchTimer.onResetTimer();
                                _isRunning = false;
                              });
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isRunning ? Colors.red : Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isRunning) {
                              // if _isRunning is true then stop timer
                              _stopWatchTimer.onStopTimer();
                            } else {
                              // eles start timer
                              _stopWatchTimer.onStartTimer();
                            }
                            _isRunning = !_isRunning;
                          });
                        },
                        child: Text(
                          _isRunning ? "Stop" : "Start",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
