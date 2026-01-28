import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/drower.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksehayak/URL/image.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xFFFFBE7B),
        title: Text("Kisan Sehayak",style: GoogleFonts.quicksand(fontSize: 23, fontWeight: FontWeight.bold,color: Colors.deepOrange),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(
                  AppImageModel.appLogo.Images, // 🔗 your network logo
                  height: 35,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: const ProfileDrawerUI(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// WELCOME
              const Text(
                "Welcome back, !",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Home Farm in your location",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 16),

              /// ALERT CARDS
              Row(
                children: [
                  _alertCard(
                    title: "Temperature",
                    time: "8:20:33 PM",
                    msg: "slightly high\nin Zone A",
                  ),
                  const SizedBox(width: 10),
                  _alertCard(
                    title: "Irrigation",
                    time: "8:20:33 PM",
                    msg: "scheduled\nfor tomorrow",
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// SENSOR CARDS
              _sensorCard(
                icon: Icons.thermostat,
                title: "Temperature",
                value: "16.9°C",
                optimal: "Optimal: 16–22°C",
                progress: 0.6,
                color: Colors.green,
              ),

              _sensorCard(
                icon: Icons.water_drop,
                title: "Humidity",
                value: "72%",
                optimal: "Optimal: 55–75%",
                progress: 0.7,
                color: Colors.green,
              ),

              _sensorCard(
                icon: Icons.wb_sunny,
                title: "Light Intensity",
                value: "73%",
                optimal: "Optimal: 70–90%",
                progress: 0.75,
                color: Colors.orange,
              ),

              _growthCard(),

              const SizedBox(height: 16),

              /// TODAY OVERVIEW
              _overviewCard(),

              const SizedBox(height: 16),

              /// CROP HEALTH
              _cropHealthCard(),

              const SizedBox(height: 16),

              /// FARM STATS
              _farmStatsCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- WIDGETS ----------------

  static Widget _alertCard({
    required String title,
    required String time,
    required String msg,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(msg),
          ],
        ),
      ),
    );
  }

  static Widget _sensorCard({
    required IconData icon,
    required String title,
    required String value,
    required String optimal,
    required double progress,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: color.withOpacity(.1),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(optimal, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  static Widget _growthCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE7FBEA),
                child: Icon(Icons.eco, color: Colors.green, size: 18),
              ),
              SizedBox(width: 8),
              Text("Growth Stage",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "Vegetative",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 6),
          Chip(
            label: Text("Active Growth"),
            backgroundColor: Color(0xFFE7FBEA),
          ),
        ],
      ),
    );
  }

  static Widget _overviewCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Overview",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("System health and activity summary",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          _overviewRow("IoT Devices Online", "12/12", true),
          _overviewRow("Irrigation Cycles", "3", false),
          _overviewRow("Data Points Collected", "1,245", false),
          _overviewRow("System Health", "Excellent", true),
        ],
      ),
    );
  }

  static Widget _overviewRow(String label, String value, bool highlight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: highlight ? Colors.green : Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  static Widget _cropHealthCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const Text("Crop Health Score",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Based on environmental conditions",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          const Text(
            "92",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const Text("Excellent Conditions",
              style: TextStyle(color: Colors.green)),
          const SizedBox(height: 12),
          _healthRow("Temperature", "Good"),
          _healthRow("Humidity", "Good"),
          _healthRow("Light", "Optimal"),
          _healthRow("Soil Moisture", "Good"),
        ],
      ),
    );
  }

  static Widget _healthRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(color: Colors.green)),
        ],
      ),
    );
  }

  static Widget _farmStatsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Farm Statistics",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("Current season performance",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: const [
              SeasonPerformance("85%", "Predicted Yield", Color(0xFFF3ECFF)),
              SeasonPerformance("45", "Days to Harvest", Color(0xFFFFF9DB)),
              SeasonPerformance("Grade A", "Quality Rating", Color(0xFFE8FFF1)),
              SeasonPerformance("5", "Acres Cultivated", Color(0xFFEFF5FF)),
            ],
          ),
        ],
      ),
    );
  }

  static BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black26,
        )
      ],
    );
  }
}

class SeasonPerformance extends StatefulWidget {
  final String value;
  final String label;
  final Color color;

  const SeasonPerformance(this.value, this.label, this.color);

  @override
  State<SeasonPerformance> createState() => _SeasonPerformanceState();
}

class _SeasonPerformanceState extends State<SeasonPerformance> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.value,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(widget.label),
        ],
      ),
    );
  }
}
