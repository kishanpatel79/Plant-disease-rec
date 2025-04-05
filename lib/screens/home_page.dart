import 'package:flutter/material.dart';
import 'image_capture_screen.dart';
import 'crop_calendar_screen.dart';
import 'weather_info_screen.dart';
import 'farmer_notes_screen.dart';
import 'last_scan_screen.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userPhone;

  const HomePage({Key? key, required this.userName, required this.userPhone})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ImageCaptureScreen(),
    CropCalendarScreen(),
    WeatherInfoScreen(),
    FarmerNotesScreen(),
    LastScanScreen(),
  ];

  final List<String> _titles = [
    "Plant Scanner",
    "Crop Care Calendar",
    "Weather Info",
    "Farmer Notes",
    "Last Scan",
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('👨‍🌾 ${widget.userName}',
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text('📞 ${widget.userPhone}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Plant Scanner'),
              onTap: () => _onItemTap(0),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Crop Care Calendar'),
              onTap: () => _onItemTap(1),
            ),
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text('Weather Info'),
              onTap: () => _onItemTap(2),
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Farmer Notes'),
              onTap: () => _onItemTap(3),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Last Scan'),
              onTap: () => _onItemTap(4),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _screens[_selectedIndex],
      ),
    );
  }
}
