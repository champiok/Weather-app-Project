import 'package:flutter/material.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text("Union"),
        actions: [CircleAvatar()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wb_sunny, size: 50.0),  // Weather Icon
                    SizedBox(width: 20.0),
                    Text("64°", style: TextStyle(fontSize: 50.0)),  // Temperature
                  ],
                ),
                Text("Partly Cloudy", style: TextStyle(fontSize: 20.0)),  // Weather description
                SizedBox(height: 20.0),
                Container(
                  height: 100.0,
                  child: ListView.builder(  // Hourly Forecast
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,  // Placeholder count
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("2pm"),  // Hour
                            Icon(Icons.wb_sunny),  // Weather Icon
                            Text("64°"),  // Temperature
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200.0,
            child: ListView.builder(  // Daily Forecast
              itemCount: 4,  // Placeholder count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.wb_sunny),  // Weather Icon
                  title: Text("Today"),  // Day
                  trailing: Text("64°"),  // Temperature
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



