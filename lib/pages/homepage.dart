import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/provider/themeprovider.dart';
import 'package:time_tracker/widgets/buildtaskandtimer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _onclicked = true;

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
              // if maxwidth < 850  ?  use vertical layout : else use horizontal layout
              bool isNarrow = constraints.maxWidth < 850;
              return isNarrow
                  ? Column(
                      children: [
                        Buildtaskandtimer(),
                        SizedBox(height: 20),
                        
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Buildtaskandtimer(),
                        SizedBox(width: 20),
                        
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
