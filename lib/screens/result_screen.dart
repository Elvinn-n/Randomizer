import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the Clipboard package

class ResultScreen extends StatelessWidget {
  final Map<String, String> assignedDuties;

  ResultScreen({required this.assignedDuties});

  // Function to copy the result to clipboard
  void copyToClipboard(BuildContext context) {
    String result = assignedDuties.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join('\n'); // Join the duties in a readable format
    Clipboard.setData(ClipboardData(text: result)); // Copy to clipboard

    // Show a SnackBar to indicate that the result has been copied
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Results copied to clipboard")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: SingleChildScrollView( // Wrap the body in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Assigned Duties", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              // List of duties
              ...assignedDuties.entries.map(
                (entry) =>
                    ListTile(title: Text(entry.key), trailing: Text(entry.value)),
              ),
              SizedBox(height: 20),
              // Copy button
              ElevatedButton(
                onPressed: () => copyToClipboard(context), // Call copy function
                child: Text("Copy"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004AAD), // Button color changed to #004aad
                  foregroundColor: Colors.white, // Set text color to white
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // Button padding
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Back button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to HomeScreen
                },
                child: Text("Back"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004AAD), // Button color changed to #004aad
                  foregroundColor: Colors.white, // Set text color to white
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ), // Button padding
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
