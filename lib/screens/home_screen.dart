import 'dart:math'; // Required for random number generation (shuffling people)
import 'package:flutter/material.dart';
import 'result_screen.dart'; // Import ResultScreen to navigate to after duty assignment

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lists for people and duties
  List<String> duties = ["job 1", "job 2", "job 3", "job 4"]; // Default duties
  final TextEditingController _nameController =
      TextEditingController(); // Controller for the name input
  final TextEditingController _dutyController =
      TextEditingController(); // Controller for the duty input
  List<String> people = []; // List of people entered by the user

  // Function to add a custom duty to the list
  void addDuty() {
    if (_dutyController.text.trim().isNotEmpty) {
      setState(() {
        duties.add(
          _dutyController.text.trim(),
        ); // Add the custom duty to the duties list
        _dutyController.clear(); // Clear the duty input field
      });
    }
  }

  // Function to assign duties randomly to people
  void assignDuties() {
    if (people.length < duties.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not enough people for the number of duties.")),
      );
      return; // If not enough people, don't proceed
    }

    final random = Random(); // Random number generator to shuffle
    List<String> shuffledPeople = List.from(people)
      ..shuffle(random); // Shuffle the people list
    Map<String, String> newAssignments = {
      for (int i = 0; i < duties.length; i++)
        duties[i]: shuffledPeople[i], // Assign shuffled people to duties
    };

    // Navigate to the result screen and pass the assignments
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(assignedDuties: newAssignments),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Randomizer",
          style: TextStyle(color: Colors.white), // Title of the app
        ),
        backgroundColor: Color(0xFF004AAD), // AppBar color changed to #004aad
      ),
      body: SingleChildScrollView(
        // Wrap the body in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the content
          child: Column(
            children: [
              // TextField for entering names
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Enter name", // Label for the name input
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add), // Add button for names
                    onPressed: () {
                      if (_nameController.text.trim().isNotEmpty) {
                        setState(() {
                          people.add(
                            _nameController.text.trim(),
                          ); // Add name to the list
                          _nameController.clear(); // Clear the name input field
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between name input and name list
              // Display entered names as chips that can be deleted
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children:
                    people.map((person) {
                      return Chip(
                        label: Text(person), // Display person's name
                        onDeleted: () {
                          setState(() {
                            people.remove(
                              person,
                            ); // Remove person from list when chip is deleted
                          });
                        },
                      );
                    }).toList(),
              ),

              SizedBox(height: 20), // Space between name list and duty input
              // TextField for entering duties
              TextField(
                controller: _dutyController,
                decoration: InputDecoration(
                  labelText: "Enter duty", // Label for the duty input
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add), // Add button for duties
                    onPressed: addDuty, // Add duty to the list when pressed
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between duty input and duty list
              // Display entered duties as chips that can be deleted
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children:
                    duties.map((duty) {
                      return Chip(
                        label: Text(duty), // Display the duty name
                        onDeleted: () {
                          setState(() {
                            duties.remove(
                              duty,
                            ); // Remove duty from list when chip is deleted
                          });
                        },
                      );
                    }).toList(),
              ),

              SizedBox(height: 30), // Space before the "Assign Duties" button
              // Button to trigger the duty assignment
              ElevatedButton(
                onPressed: assignDuties, // Call the assignDuties function when pressed
                child: Text("Assign Duties"), // Button label
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004AAD), // Button background color
                  foregroundColor: Colors.white, // Button text color (white)
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // Button padding
                  textStyle: TextStyle(
                    fontSize: 16,
                  ), // Text style for font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
