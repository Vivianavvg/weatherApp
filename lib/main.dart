import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  WeatherHomePageState createState() => WeatherHomePageState();
}

class WeatherHomePageState extends State<WeatherHomePage> {
  List<Map<String, String>> _weekForecast = [];

  final TextEditingController _cityController = TextEditingController();
  final conditions = ['Sunny', 'Cloudy', 'Rainy'];

  String cityName = 'City Name';
  String temperature = 'Temperature';
  String weatherCondition = 'Condition';

  void _fetchWeather() {
    setState(() {
      if (_cityController.text.isEmpty || _cityController.text == cityName) {
        return;
      }
      cityName =
          _cityController.text.isNotEmpty ? _cityController.text : 'Unknown';
      temperature = '${15 + Random().nextInt(16)}°C';
      weatherCondition = conditions[Random().nextInt(conditions.length)];
    });
  }

  void _getWeekForecast() {
    setState(() {
      _weekForecast = [
        {'day': 'Sunday', 'temp': '18'},
        {'day': 'Monday', 'temp': '21'},
        {'day': 'Tuesday', 'temp': '22'},
        {'day': 'Wednesday', 'temp': '24'},
        {'day': 'Thursday', 'temp': '23'},
        {'day': 'Friday', 'temp': '21'},
        {'day': 'Saturday', 'temp': '20'},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Fetch Weather'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueGrey, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    cityName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    temperature,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weatherCondition,
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SevenDayForecast(
              weekForecast: _weekForecast,
              onGetForecast: _getWeekForecast,
            ),
          ],
        ),
      ),
    );
  }
}

// Seven day forecast widget
class SevenDayForecast extends StatelessWidget {
  final List<Map<String, String>> weekForecast;
  final VoidCallback onGetForecast;

  const SevenDayForecast({
    super.key,
    required this.weekForecast,
    required this.onGetForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 223, 223),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueGrey, width: 2),
      ),
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud),
                Text(
                  ' 7-day forecast ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.cloud),
              ],
            ),
            const SizedBox(height: 10),
            weekForecast.isNotEmpty
                ? Container(
                    color: Colors.white,
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Day',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Temp (°C)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...weekForecast.map((dayForecast) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(dayForecast['day']!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(dayForecast['temp']!),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onGetForecast,
              child: const Text('Get 7-day forecast'),
            ),
          ],
        ),
      ),
    );
  }
}
