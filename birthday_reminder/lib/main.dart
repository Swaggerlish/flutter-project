import 'package:flutter/material.dart';
import 'package:birthday_reminder/Model/event.dart';
import 'package:birthday_reminder/Model/birthday_model.dart';
import 'event_table.dart';

void main() {
  runApp(const BirthdayReminder());
}

class BirthdayReminder extends StatelessWidget {
  const BirthdayReminder({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable debug banner
      debugShowCheckedModeBanner: false,

      // App title
      title: 'Birthday App',

      // Set theme color
      theme: ThemeData(primarySwatch: Colors.green),

      // Set the home screen
      home: const BirthdayReminderApp(),
    );
  }
}

class BirthdayReminderApp extends StatefulWidget {
  const BirthdayReminderApp({super.key});

  @override
  _BirthdayReminderAppState createState() => _BirthdayReminderAppState();
}

class _BirthdayReminderAppState extends State<BirthdayReminderApp> {
  // Controllers for name and date input fields
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // List to store birthdays
  List<Birthday> birthdays = [];

  // Selected date for the birthday
  DateTime selectedDate = DateTime.now();

  // List to store events
  List<Event> eventList = [];

  // Variable to hold a single event
  var event;

  // Default date values
  late int date = 1;
  late int month = 1;
  late int year = 2023;

  // Function to show a SnackBar with a message
  _showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Function to open a date picker and select a date
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,

      // Earliest selectable date
      firstDate: DateTime(2000),

      // Latest selectable date
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        // Update selected date
        selectedDate = pickedDate;

        // Update date controller
        dateController.text = selectedDate.toString();
      });
    }
  }

  // Function to set an event for a specific date
  setEvent(name, date) {
    // Create a new event
    event = Event(name + " Birthday");

    if (kEventSource[date] == null) {
      // If no events exist for the date,
      // create a new list
      eventList = [event];
      kEventSource.addAll({
        date: eventList,
      });

      setState(() {
        // Update the events map
        kEvents = kEvents;
      });
    } else {
      // If events exist, add the
      // new event to the list
      kEventSource[date]!.add(event);
      setState(() {
        // Update the events map
        kEvents.addAll(kEventSource);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'The Birthday',
          style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
        ), // AppBar title
        backgroundColor: Colors.green, // AppBar background color
        foregroundColor: Colors.white, // AppBar text color
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color(0xffe4fafb),
          image: DecorationImage(
            image: AssetImage("assets/balloons.png"), // Background image
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: birthdays.length, // Number of birthdays
          itemBuilder: (context, index) {
            Birthday birthday = birthdays[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white, // Container background color
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(birthday.name), // Display birthday name
                subtitle: Text(
                  '${birthday.date.day}/${birthday.date.month}/${birthday.date.year}',
                ), // Display birthday date
                trailing: const Icon(Icons.cake), // Cake icon
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green, // Button background color
        foregroundColor: Colors.white, // Button icon color
        shape: const OvalBorder(), // Circular button shape
        onPressed: () {
          nameController.text = ""; // Clear name field
          dateController.text = ""; // Clear date field
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text(
                  'Add new Birthday!!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ), // Dialog title
                content: SizedBox(
                  height: 265,
                  child: Column(
                    children: [
                      // Name input field
                      Row(
                        children: [
                          const Icon(Icons.person_2_rounded),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(labelText: 'Name'),
                            ),
                          ),
                        ],
                      ),
                      // Date input field with calendar picker
                      Row(
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.calendar_today),
                            onTap: () {
                              _selectDate(context); // Open date picker
                            },
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextField(
                              controller: dateController,
                              decoration:
                                  const InputDecoration(labelText: 'Picked Date'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Button to add birthday
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              dateController.text.isEmpty) {
                            _showSnackBar(
                                'Make sure both name and date is provided.????');
                          } else {
                            DateTime? parsedDate =
                                DateTime.tryParse(dateController.text);
                            if (parsedDate != null) {
                              Birthday newBirthday = Birthday(
                                name: nameController.text,
                                date: parsedDate,
                              );
                              setState(() {
                                birthdays.add(newBirthday); // Add new birthday
                              });

                              Navigator.pop(context); // Close the dialog
                              _showSnackBar('Birthday added 🎂');
                              setEvent(
                                  nameController.text, parsedDate); // Set event
                            } else {
                              _showSnackBar('Invalid Date!');
                            }
                          }
                        },
                        child: const Text('Add Birthday'),
                      ),
                      const SizedBox(height: 10),
                      // Button to view events
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("View Events"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const EventTable()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: "Add Birthday", // Tooltip for the button
        child: const Icon(Icons.add), // Add icon
      ),
    );
  }
}
