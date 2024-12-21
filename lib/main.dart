import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoColler Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AutoColler Dashboard'),
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
  bool isFanOn = false;
  bool isAcOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Scrollbar(
        // Menambahkan Scrollbar
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang di AutoColler!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              // Grafik LineChart
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 3),
                            FlSpot(1, 6),
                            FlSpot(2, 5),
                            FlSpot(3, 2),
                            FlSpot(4, 4),
                          ],
                          isCurved: true,
                          color: Colors.deepPurple,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.deepPurple.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Kartu Temperatur dan Kelembapan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircularCard('30°C', 'Temperature'),
                  _buildCircularCard('50%', 'Humidity'),
                ],
              ),
              const SizedBox(height: 16),
              // Kontrol Kipas dan AC
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSwitchCard('Atur Kipas', isFanOn, (value) {
                    setState(() {
                      isFanOn = value;
                    });
                  }),
                  _buildSwitchCard('Atur AC', isAcOn, (value) {
                    setState(() {
                      isAcOn = value;
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan kartu melingkar
  Widget _buildCircularCard(String value, String label) {
    return Expanded(
      child: Card(
        color: Colors.deepPurple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      strokeWidth: 6,
                      color: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.shade100,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.deepPurple, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan kartu dengan tombol saklar
  Widget _buildSwitchCard(
      String label, bool value, ValueChanged<bool> onChanged) {
    return Expanded(
      child: Card(
        color: Colors.deepPurple.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.deepPurple,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.deepPurple, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
