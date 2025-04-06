import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:time_tracker/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _taskName = TextEditingController();
  bool _isRunning = false;
  bool _onclicked = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _taskName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TIME TRACKER",
          textScaler: TextScaler.linear(1),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _onclicked = !_onclicked;
                });
                themeProvider.toggleTheme();
              },
              child: _onclicked
                  ? Icon(
                      Iconsax.sun,
                      size: 20,
                    )
                  : Icon(
                      Iconsax.moon,
                      size: 20,
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          // using layoutbuilder for responsive UI
          child: LayoutBuilder(
            builder: (context, constraints) {
              // if maxwidth is smaller that 850 use vertical layout or else use horizontal layout
              bool isNarrow = constraints.maxWidth < 850;
              return isNarrow
                  ? Column(
                      children: [
                        _buildTaskAndTimer(_taskName),
                        SizedBox(height: 20),
                        _buildHistory(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTaskAndTimer(_taskName),
                        SizedBox(width: 20),
                        _buildHistory(),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTaskAndTimer(TextEditingController controller) {
    return Column(
      children: [
        Container(
          height: 300,
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.deepPurple,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tasks",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    int _selectedHour = 0;
                    int _selectedMinute = 0;
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (context) {
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
                                SizedBox(height: 20),
                                SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                                        value: _selectedHour,
                                                        zeroPad: true,
                                                        infiniteLoop: false,
                                                        itemHeight: 40,
                                                        itemWidth: 80,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _selectedHour =
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
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            bottom: BorderSide(
                                                              color:
                                                                  Colors.black,
                                                            ),
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
                                                        value: _selectedMinute,
                                                        zeroPad: true,
                                                        infiniteLoop: false,
                                                        itemHeight: 40,
                                                        itemWidth: 80,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _selectedMinute =
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
                                                            top: BorderSide(),
                                                            bottom:
                                                                BorderSide(),
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
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  onPressed: () {
                                    _taskName.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Add task",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
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
                // todo adding task data should be displayed below
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
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

  Widget _buildHistory() {
    return Container(
      height: 520,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Previous Task History",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // todo over here create a list view builder which shows list tile of history created by user
          ],
        ),
      ),
    );
  }
}
