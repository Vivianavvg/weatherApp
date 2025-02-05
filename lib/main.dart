import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> _weekForecast = [];

  void _getWeekForecast() {
    setState(() {
      _weekForecast = [
        {'day': 'Sunday', 'temp': '65'},
        {'day': 'Monday', 'temp': '70'},
        {'day': 'Tuesday', 'temp': '72'},
        {'day': 'Wednesday', 'temp': '75'},
        {'day': 'Thursday', 'temp': '73'},
        {'day': 'Friday', 'temp': '70'},
        {'day': 'Saturday', 'temp': '68'},
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                                'Temp (°F)',
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
