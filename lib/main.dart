import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataManager(),
      child: MyApp(),
    ),
  );
}

class DataManager extends ChangeNotifier {
  String _data =
      'This is the data that will change when the button is pressed.';
  String _previousData = ''; // Track previous data
  bool _buttonPressed = false; // Track button state

  String get data => _data;
  bool get buttonPressed => _buttonPressed;

  void updateData(String newData) {
    _previousData = _data; // Store previous data
    _data = newData;
    _buttonPressed = !_buttonPressed; // Toggle button state
    notifyListeners(); // Notify listeners when data changes
  }

  void revertData() {
    // Revert data to the previous state
    _data = _previousData;
    _buttonPressed = false; // Button is now in the "Update Data" state
    notifyListeners(); // Notify listeners when data changes
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define dataManager variable
    DataManager dataManager = Provider.of<DataManager>(context);

    return MaterialApp(
      title: 'Centralised Data Manager Example',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Centralised Data Manager Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Add the Heading and Arrow Icon
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Data Management',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.arrow_downward),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 20),
              // Step 3: Listen for Data Changes
              Consumer<DataManager>(
                builder: (context, dataManager, child) {
                  return Container(
                    alignment: Alignment.center,
                    width: 350,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.arrow_forward),
                            SizedBox(width: 10),
                            Text(
                              'Data',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          dataManager.data,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (dataManager.buttonPressed) {
                    // If button is in "Revert Data" state, revert data
                    dataManager.revertData();
                  } else {
                    // Otherwise, update data
                    dataManager.updateData(
                      'The data has changed and it got updated in real-time.',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: dataManager.buttonPressed
                      ? Colors.redAccent
                      : Colors.lightGreen, // Change button color based on buttonPressed state
                ),
                child: Text(dataManager.buttonPressed
                    ? 'Revert Data'
                    : 'Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
