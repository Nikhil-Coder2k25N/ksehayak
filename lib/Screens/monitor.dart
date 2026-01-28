import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:ksehayak/Screens/drower.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksehayak/URL/image.dart';


class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int selectedTab = 0;

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
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Crop Monitoring &\nAnalytics",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Track growth, analyze performance, and monitor quality",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              /// TABS
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _tab("Daily Reports", 0),
                    _tab("Weekly Reports", 1),
                    _tab("Historical Data", 2),
                    _tab("AI Predictions", 3),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              if (selectedTab == 0) _dailyUI(),
              if (selectedTab == 1) _weeklyUI(),
              if (selectedTab == 2) _historicalUI(),
              if (selectedTab == 3) _aiPredictionUI(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(String text, int index) {
    final selected = selectedTab == index;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(text),
        selected: selected,
        onSelected: (_) => setState(() => selectedTab = index),
        selectedColor: Colors.green.shade200,
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? Colors.black : Colors.black54,
        ),
      ),
    );
  }

  // ================= DAILY =================

  Widget _dailyUI() {
    return Column(
      children: [
      Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.blue, width: 2),
        ),
        color: const Color(0xFFFFFFFF), // beige
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Today's Environmental Conditions",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("24-hour temperature and humidity trends",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 4,
                    minY: 0,
                    maxY: 80,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.white,
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((spot) {
                            final isTemp = spot.barIndex == 0;

                            return LineTooltipItem(
                              isTemp
                                  ? 'Temperature (°C) : ${spot.y.toInt()}\n'
                                  : 'Humidity (%) : ${spot.y.toInt()}',
                              TextStyle(
                                color: isTemp ? Colors.red : Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                    gridData: FlGridData(show: true, drawVerticalLine: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const labels = ['04:00', '08:00', '12:00', '16:00', '20:00'];
                            if (value.toInt() >= 0 && value.toInt() < labels.length) {
                              return Text(labels[value.toInt()], style: TextStyle(fontSize: 10));
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 40),
                          FlSpot(1, 30),
                          FlSpot(2, 40),
                          FlSpot(3, 30),
                          FlSpot(4, 40),
                        ],
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 48),
                          FlSpot(1, 50),
                          FlSpot(2, 39),
                          FlSpot(3, 50),
                          FlSpot(4, 40),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.red),
                  SizedBox(width: 6),
                  Text("Temperature (°C)", style: TextStyle(fontSize: 12)),
                  SizedBox(width: 14),
                  Icon(Icons.circle, size: 8, color: Colors.blue),
                  SizedBox(width: 6),
                  Text("Humidity (%)", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _metricCard("Growth Rate", "+3.2%", "vs. yesterday", "Above Average", Colors.green),
        _metricCard("Nutrient Uptake", "95%", "Optimal levels", "Healthy", Colors.black),
        _metricCard("Water Consumption", "245L", "Today's usage", "Normal", Colors.black),
      ],
    );
  }

  // ================= WEEKLY =================

  Widget _weeklyUI() {
    return Column(
      children: [
      Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.purple, width: 2),
        ),
        color: const Color(0xFFFFFFFF), // beige
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Weekly Growth & Quality Metrics",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("7-day performance overview",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.white,
                          tooltipRoundedRadius: 12,
                          tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            if (rodIndex == 0) {
                              return BarTooltipItem(
                                'Growth Rate (%) : ${(rod.toY * 3.4 / 100).toStringAsFixed(1)}\n',
                                const TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            } else {
                              return BarTooltipItem(
                                'Quality Score : ${rod.toY.toInt()}',
                                const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      maxY: 100,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 20,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.3),
                            strokeWidth: 1,
                            dashArray: [4, 4],
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                        /// LEFT AXIS → Growth %
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 25,
                            getTitlesWidget: (value, meta) {
                              double growth = (value / 100) * 3.4;
                              return Text(growth.toStringAsFixed(2),
                                  style: const TextStyle(fontSize: 10));
                            },
                          ),
                        ),

                        /// RIGHT AXIS → Quality Score
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 25,
                            getTitlesWidget: (value, meta) =>
                                Text(value.toInt().toString(), style: const TextStyle(fontSize: 10)),
                          ),
                        ),

                        /// BOTTOM DAYS
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['Mon', 'Wed', 'Fri', 'Sun'];
                              return Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(days[value.toInt()],
                                    style: const TextStyle(fontSize: 11)),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        _weeklyBar(0, 2.6, 85),
                        _weeklyBar(1, 3.0, 88),
                        _weeklyBar(2, 3.3, 90),
                        _weeklyBar(3, 3.1, 92),
                      ],
                    )
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.square, size: 10, color: Colors.purple),
                  SizedBox(width: 6),
                  Text("Growth Rate (%)"),
                  SizedBox(width: 16),
                  Icon(Icons.square, size: 10, color: Colors.orange),
                  SizedBox(width: 6),
                  Text("Quality Score"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Weekly Summary", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SummaryRow("Average Growth Rate", "+2.97%"),
              SummaryRow("Average Quality Score", "88/100"),
              SummaryRow("Best Day", "Sunday"),
              SummaryRow("Total Water Used", "1,715L"),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Performance Insights", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              InsightBox("Growth rate is 15% above average for this season", Colors.green),
              InsightBox("Quality scores trending upward consistently", Colors.blue),
              InsightBox("Optimal conditions maintained 92% of the time", Colors.purple),
            ],
          ),
        ),
      ],
    );
  }
  BarChartGroupData _barGroup(int x, double growth, double quality) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: growth, color: Colors.purple, width: 8),
        BarChartRodData(toY: quality, color: Colors.orange, width: 8),
      ],
    );
  }

  // ================= HISTORICAL =================

  Widget _historicalUI() {
    return Column(
      children: [
      Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF), // beige background
        borderRadius: BorderRadius.circular(18),
        border: Border(
          bottom: BorderSide(color: Colors.purple, width: 2),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Historical Yield Comparison",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Performance across seasons",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 800,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 200,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.brown.withOpacity(0.3),
                          strokeWidth: 1,
                          dashArray: [5, 5], // dashed grid
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 200,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString(),
                                style: const TextStyle(fontSize: 10));
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const labels = ["Fall '23", "Spring '24", "Fall '24", "Current"];
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(labels[value.toInt()],
                                  style: const TextStyle(fontSize: 11)),
                            );
                          },
                        ),
                      ),
                    ),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.white,
                        tooltipRoundedRadius: 10,
                        tooltipPadding: const EdgeInsets.all(8),
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            'Yield : ${rod.toY.toInt()} kg',
                            const TextStyle(
                              color: Colors.purple,
                            ),
                          );
                        },
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      _thinBar(0, 450),
                      _thinBar(1, 350),
                      _thinBar(2, 580),
                      _thinBar(3, 620),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Yield (kg)",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),
              const Center(child: Text("Yield (kg)")),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _yieldCard("Fall '23", "450 kg", "Grade A"),
        _yieldCard("Spring '24", "520 kg", "Grade A"),
        _yieldCard("Fall '24", "580 kg", "Grade A+"),
        _yieldCard("Current", "620 kg", "Grade A+"),
      ],
    );
  }

  // ================= AI =================
  Widget _aiPredictionUI() {
    return Column(
      children: [

        /// AI YIELD PREDICTION
        _card(
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.psychology_outlined, size: 25),
                  SizedBox(width: 6),
                  Text("AI-Based Yield Prediction",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                "Machine learning forecasts for current season",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                "650 kg",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const Text("Predicted Total Yield"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("95% Confidence",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 12),
              const Text(
                "Based on current growth patterns, environmental conditions, and historical data, our AI predicts an exceptional harvest this season.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),

        const SizedBox(height: 18),

        /// QUALITY GRADE PREDICTION
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Quality Grade Prediction",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Grade A+",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Premium quality expected"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Confidence: 92%",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        /// HARVEST DATE
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Harvest Date",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("45 days",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Estimated time to harvest",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("March 12, 2026"),
              )
            ],
          ),
        ),

        const SizedBox(height: 18),

        /// MARKET VALUE
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Market Value",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("₹87.5L",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Estimated revenue",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Above Target",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),

        const SizedBox(height: 18),

        /// SAFFRON QUALITY GRADING
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Saffron Quality Grading",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Current crop quality assessment",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              _gradeBox("Grade A", "20%", Colors.orange.shade200, Colors.orange),
              const SizedBox(height: 14),
              _gradeBox("Grade A+", "75%", Colors.purple.shade50, Colors.purple),
              const SizedBox(height: 14),
              _gradeBox("Grade B", "5%", Colors.grey.shade100, Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  // ================= COMMON =================

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  Widget _gradeBox(String title, String percent, Color bg, Color border) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border, width: 2),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(percent, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text("Expected yield", style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }


  Widget _metricCard(String title, String value, String sub, String chip, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            Text(sub, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Chip(label: Text(chip)),
          ],
        ),
      ),
    );
  }

  Widget _yieldCard(String season, String value, String grade) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(season),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Chip(label: Text(grade)),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String l;
  final String r;
  const SummaryRow(this.l, this.r, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l),
        Text(r, style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

class InsightBox extends StatelessWidget {
  final String text;
  final Color color;
  const InsightBox(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }
}
BarChartGroupData _thinBar(int x, double value) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: value,
        width: 28, // thin bars
        borderRadius: BorderRadius.circular(4),
        color: Colors.purple,
      ),
    ],
  );
}
BarChartGroupData _weeklyBar(int x, double growth, double quality) {
  return BarChartGroupData(
    x: x,
    barsSpace: 6,
    barRods: [
      /// Growth bar (scaled to 0–100)
      BarChartRodData(
        toY: (growth / 3.4) * 100,
        width: 7,
        borderRadius: BorderRadius.circular(4),
        color: Colors.purple,
      ),

      /// Quality bar
      BarChartRodData(
        toY: quality,
        width: 7,
        borderRadius: BorderRadius.circular(4),
        color: Colors.orange,
      ),
    ],
  );
}




