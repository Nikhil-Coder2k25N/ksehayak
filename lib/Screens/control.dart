import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/drower.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksehayak/URL/image.dart';
class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {

  bool automation = true;

  bool zoneA = true;
  bool zoneB = true;
  bool irrigation = false;
  bool fan = true;
  bool humidifier = true;
  bool backupPower = false;

  double zoneAIntensity = 0.75;
  double zoneBIntensity = 0.80;
  double fanIntensity = 0.60;
  double humidifierIntensity = 0.65;

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
              /// HEADER
              const Text(
                "IoT Device Control",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Manage and monitor your smart farm devices",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 16),

              /// AUTOMATION CARD
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _switchRow(
                      title: "Automation Mode",
                      subtitle: "Let AI manage device settings automatically",
                      value: automation,
                      onChanged: (v) => setState(() => automation = v),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF3FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "⚡ Automation is active. Devices will be automatically "
                            "controlled based on environmental conditions.\n\n"
                            "You can still manually override any device at any time.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// FILTER TABS
              Wrap(
                spacing: 8,
                children: const [
                  Chip(label: Text("All Devices")),
                  Chip(label: Text("Lights")),
                  Chip(label: Text("Climate")),
                  Chip(label: Text("Irrigation")),
                ],
              ),

              const SizedBox(height: 16),

              /// DEVICES
              _deviceSlider(
                icon: Icons.lightbulb_outline,
                title: "LED Grow Lights - Zone A",
                online: true,
                value: zoneAIntensity,
                switchValue: zoneA,
                onSwitch: (v) => setState(() => zoneA = v),
                onChanged: (v) => setState(() => zoneAIntensity = v),
              ),

              _deviceSlider(
                icon: Icons.lightbulb_outline,
                title: "LED Grow Lights - Zone B",
                online: true,
                value: zoneBIntensity,
                switchValue: zoneB,
                onSwitch: (v) => setState(() => zoneB = v),
                onChanged: (v) => setState(() => zoneBIntensity = v),
              ),

              _deviceSimple(
                icon: Icons.water_drop_outlined,
                title: "Irrigation System",
                online: true,
                value: irrigation,
                onChanged: (v) => setState(() => irrigation = v),
              ),

              _deviceSlider(
                icon: Icons.air,
                title: "Climate Control Fan",
                online: true,
                value: fanIntensity,
                switchValue: fan,
                onSwitch: (v) => setState(() => fan = v),
                onChanged: (v) => setState(() => fanIntensity = v),
              ),

              _humidifierCard(),

              _deviceSimple(
                icon: Icons.bolt,
                title: "Backup Power Unit",
                online: true,
                value: backupPower,
                onChanged: (v) => setState(() => backupPower = v),
              ),

              const SizedBox(height: 16),

              /// MACHINE HEALTH
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Machine Health Monitoring",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Overall system performance and health",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: const [
                        _healthBox("98%", "System Uptime", Icons.show_chart,
                            Colors.green),
                        _healthBox("2.4 KW", "Power Usage", Icons.flash_on,
                            Colors.deepPurple),
                        _healthBox("12/12", "Devices Online", Icons.check_circle,
                            Colors.green),
                        _healthBox("1", "Needs Maintenance",
                            Icons.error_outline, Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI WIDGETS ----------------

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: child,
    );
  }

  Widget _switchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _deviceSlider({
    required IconData icon,
    required String title,
    required bool online,
    required double value,
    required bool switchValue,
    required ValueChanged<bool> onSwitch,
    required ValueChanged<double> onChanged,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade50,
                child: Icon(icon, color: Colors.deepPurple),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Online",
                          style:
                          TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              Switch(value: switchValue, onChanged: onSwitch),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Intensity Level"),
              Text("${(value * 100).round()}%"),
            ],
          ),
          Slider(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _deviceSimple({
    required IconData icon,
    required String title,
    required bool online,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _card(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("Online",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _humidifierCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange.shade50,
                child: const Icon(Icons.opacity, color: Colors.orange),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text("Humidifier",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Switch(
                  value: humidifier,
                  onChanged: (v) => setState(() => humidifier = v)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Intensity Level"),
              Text("65%"),
            ],
          ),
          Slider(
            value: humidifierIntensity,
            onChanged: (v) => setState(() => humidifierIntensity = v),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "⚠ Maintenance required soon. Last service: 45 days ago",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _healthBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _healthBox(this.value, this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 6),
          Text(value,
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
