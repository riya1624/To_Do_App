import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

// Color Palette
const Color primaryColor = Color(0xFF78A2CC); // Soft Blue
const Color secondaryColor = Color(0xFF88AED0); // Muted Light Blue
const Color accentColor = Color(0xFF96B9D0); // Light Blue-Gray
const Color buttonColor = Color(0xFFA4C3D2); // Soft, Desaturated Blue
const Color backgroundColor = Color(0xFFAECBD6); // Light Blue-Gray

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App with Custom Palette',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: buttonColor, // Button color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor, // Text color for buttons
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _taskController = TextEditingController();
  List<String> _tasks = [];

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), // Image background
            fit: BoxFit.cover, // Ensures the image covers the whole screen
          ),
        ),
        child: Stack(
          children: [
            // Semi-transparent overlay to darken the image
            Container(
              color: const Color.fromARGB(255, 245, 245, 249).withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Task input field
                  Container(
                    height: 100.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 3, 40, 70)
                              .withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          labelText: 'Enter a task',
                          labelStyle: TextStyle(
                              color: const Color.fromARGB(255, 246, 247, 248)),
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Add Task button with custom color
                  ElevatedButton(
                    onPressed: _addTask,
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // List of tasks
                  Expanded(
                    child: _tasks.isEmpty
                        ? Center(
                            child: Text(
                              'No tasks available. Add a task to get started!',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white70),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _tasks.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                  color: secondaryColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color.fromARGB(255, 2, 16, 49)
                                              .withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                    _tasks[index],
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete,
                                        color: const Color.fromARGB(
                                            255, 231, 240, 246)),
                                    onPressed: () => _removeTask(index),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
