import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ksehayak/Screens/drower.dart';
import 'package:ksehayak/URL/image.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() =>
      _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {

  BarChartGroupData _financeGroup(int x, double revenue, double cost, double profit) {
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [
        BarChartRodData(toY: revenue, color: Colors.purple, width: 7),
        BarChartRodData(toY: cost, color: Colors.orange, width: 7),
        BarChartRodData(toY: profit, color: Colors.green, width: 7),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    calculateROI();
  }

  final TextEditingController investmentCtrl = TextEditingController(text: "200000");
  final TextEditingController revenueCtrl = TextEditingController(text: "250000");
  final TextEditingController costCtrl = TextEditingController(text: "150000");

  double roi = 0;
  double annualProfit = 0;
  double paybackYears = 0;
  double investment = 0;

  void calculateROI() {
    double investment = double.tryParse(investmentCtrl.text) ?? 0;
    double revenue = double.tryParse(revenueCtrl.text) ?? 0;
    double cost = double.tryParse(costCtrl.text) ?? 0;

    annualProfit = revenue - cost;

    if (investment > 0) {
      roi = (annualProfit / investment) * 100;
      paybackYears = annualProfit > 0 ? investment / annualProfit : 0;
    } else {
      roi = 0;
      paybackYears = 0;
    }

    setState(() {});
  }

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
              const Text("Financial Management",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                "Track costs, calculate ROI, and explore funding opportunities",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),

              /// TABS
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _tab("Overview", 0),
                    _tab("ROI Calculator", 1),
                    _tab("Government Schemes", 2),
                    _tab("Investor Dashboard", 3),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              if (selectedTab == 0) _overviewUI(),
              if (selectedTab == 1) _roiUI(),
              if (selectedTab == 2) _schemesUI(),
              if (selectedTab == 3) _investorUI(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(String t, int i) {
    final selected = selectedTab == i;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(t),
        selected: selected,
        onSelected: (_) => setState(() => selectedTab = i),
      ),
    );
  }

  // ================= OVERVIEW =================

  Widget _overviewUI() {
    return Column(
      children: [
        _statCard("Total Revenue", "₹2.03L", "This year", "+18%", Colors.green),
        _statCard("Net Profit", "₹84K", "This quarter", "+22%", Colors.purple),
        _statCard("Total Costs", "₹1.19L", "This quarter", "+8%", Colors.grey),
        _statCard("Profit Margin", "41.4%", "Above target", "Excellent", Colors.green),

        const SizedBox(height: 16),

        /// COST BREAKDOWN PIE
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Revenue vs Costs Analysis",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Monthly financial performance",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              SizedBox(
                height: 220,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 60000,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 15000,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                        dashArray: [4, 4],
                      ),
                    ),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 15000,
                          getTitlesWidget: (value, meta) => Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const months = ['Oct', 'Nov', 'Dec', 'Jan'];
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(months[value.toInt()],
                                  style: const TextStyle(fontSize: 11)),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      _financeGroup(0, 45000, 28000, 17000),
                      _financeGroup(1, 52000, 30000, 22000),
                      _financeGroup(2, 48000, 29000, 19000),
                      _financeGroup(3, 60000, 32000, 28000),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Legend(color: Colors.purple, text: "Revenue (₹)"),
                  _Legend(color: Colors.orange, text: "Costs (₹)"),
                  _Legend(color: Colors.green, text: "Profit (₹)"),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Cost Breakdown",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text("Where your money goes",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              SizedBox(height: 200,width: 280, child: PieChart(_pieData()),),
            ],
          ),
        ),

        const SizedBox(height: 16),
        _financialSummary(),
      ],
    );
  }

  Widget _financialSummary() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Financial Summary",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          _SummaryBox("Average Revenue/Month", "₹50,750"),
          _SummaryBox("Average Costs/Month", "₹29,750"),
          _SummaryBox("ROI (Annual)", "52%"),
          _SummaryBox("Break-even Point", "18 months"),
        ],
      ),
    );
  }

  // ================= ROI =================

  Widget _roiUI() {
    return Column(
      children: [

        /// INPUT CARD
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("ROI Calculator",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              _InputField("Initial Investment (₹)", investmentCtrl),
              _InputField("Expected Annual Revenue (₹)", revenueCtrl),
              _InputField("Expected Annual Costs (₹)", costCtrl),
            ],
          ),
        ),

        const SizedBox(height: 16),

        /// RESULTS CARD
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Calculation Results",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text("Based on your inputs",
                  style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 16),

              /// ROI BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F2FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text("Return on Investment",
                        style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 8),
                    Text(
                      "${roi.toStringAsFixed(1)}%",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Per Year",
                        style:
                        TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// PROFIT + PAYBACK
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          const Text("Annual Profit",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 6),
                          Text(
                            "₹${annualProfit.toStringAsFixed(0)}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          const Text("Payback Period",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 6),
                          Text(
                            "${paybackYears.isFinite ? paybackYears.toStringAsFixed(1) : 0} years",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// PRO TIP
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("💡", style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Pro Tip: With the current figures, you'll recover your investment in ${paybackYears.isFinite ? paybackYears.toStringAsFixed(1) : 0} years and earn ${roi.toStringAsFixed(1)}% annual return.",
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= SCHEMES =================

  Widget _schemesUI() {
    return Column(
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  Icon(Icons.description_outlined),
                  SizedBox(width: 8),
                  Text("Government Schemes & Subsidies",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              SizedBox(height: 4),
              Text("Funding opportunities for saffron farmers",
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        _schemeItem(
          title: "National Horticulture Mission",
          subtitle: "Small & marginal farmers",
          amount: "₹50,000",
          active: true,
        ),

        _schemeItem(
          title: "PM-KUSUM Scheme",
          subtitle: "Solar equipment subsidy",
          amount: "₹75,000",
          active: true,
        ),

        _schemeItem(
          title: "Agricultural Infrastructure Fund",
          subtitle: "Infrastructure development",
          amount: "₹2,00,000",
          active: false,
        ),


        const SizedBox(height: 16),
        _applicationGuide(),
      ],
    );
  }

  Widget _applicationGuide() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Application Guide",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _GuideStep(
              number: "1",
              title: "Check Eligibility",
              subtitle: "Review the eligibility criteria for each scheme"),
          _GuideStep(
              number: "2",
              title: "Prepare Documents",
              subtitle:
              "Land records, Aadhaar, bank details, and farming certificates"),
          _GuideStep(
              number: "3",
              title: "Submit Application",
              subtitle: "Apply online through the respective portal"),
          _GuideStep(
              number: "4",
              title: "Track Status",
              subtitle: "Monitor your application status online"),
        ],
      ),
    );
  }

  // ================= INVESTOR =================

  Widget _investorUI() {
    return Column(
      children: [
        _card(
          child: Column(
            children: const [
              Icon(Icons.adjust, color: Colors.purple, size: 30),
              SizedBox(height: 8),
              Text("Portfolio Value"),
              SizedBox(height: 6),
              Text("₹15.2L",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Chip(
                label: Text("+24% YTD"),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        _card(
          child: Column(
            children: const [
              Icon(Icons.currency_rupee, color: Colors.green, size: 30),
              SizedBox(height: 8),
              Text("Total Returns"),
              SizedBox(height: 6),
              Text("₹2.8L",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Chip(
                label: Text("This Year"),
                backgroundColor: Colors.purple,
                labelStyle: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        _card(
          child: Column(
            children: const [
              Icon(Icons.trending_up, color: Colors.purple, size: 30),
              SizedBox(height: 8),
              Text("Active Farms"),
              SizedBox(height: 6),
              Text("8",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Chip(label: Text("Diversified"))
            ],
          ),
        ),
        const SizedBox(height: 16),
        _investmentOpportunities(),
      ],
    );
  }

  Widget _investmentOpportunities() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Investment Opportunities",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("New farms seeking investment",
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),

          _farmCard("Kashmir Valley", "10 acres", "ROI: 45%", 18, 25),
          _farmCard("Pampore Region", "5 acres", "ROI: 38%", 12, 15),
          _farmCard("Pulwama District", "8 acres", "ROI: 42%", 8, 20),
        ],
      ),
    );
  }

  // ================= SMALL COMPONENTS =================

  Widget _statCard(String title, String value, String sub, String chip,
      Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
            const SizedBox(height: 20),
            Text(value,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            if (sub.isNotEmpty)
              Text(sub, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Chip(label: Text(chip))
          ],
        ),
      ),
    );
  }

  Widget _schemeCard(
      String title, String sub, String amount, bool active) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(sub, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 6),
                    Text(amount,
                        style: const TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                  ],
                )),
            Column(
              children: [
                Chip(
                    label: Text(active ? "Active" : "Coming Soon"),
                    backgroundColor:
                    active ? Colors.green : Colors.orange),
                ElevatedButton(onPressed: () {}, child: const Text("Apply Now"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _farmCard(String name, String size, String roi, int raised, int target) {
    double progress = raised / target;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("View Details"),
              )
            ],
          ),
          const SizedBox(height: 6),
          Text("Size: $size   •   Target $roi",
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          const Text("Funding Progress"),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(Colors.purple),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text("₹${raised}L / ₹${target}L",
                style:
                const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: child,
    );
  }

  PieChartData _pieData() {
    return PieChartData(sections: [
      PieChartSectionData(value: 35, color: Colors.purple, title: "Equipment"),
      PieChartSectionData(value: 20, color: Colors.orange, title: "Labor"),
      PieChartSectionData(value: 25, color: Colors.green, title: "Supplies"),
      PieChartSectionData(value: 15, color: Colors.blue, title: "Maintenance"),
      PieChartSectionData(value: 5, color: Colors.red, title: "Other"),
    ]);
  }

  BarChartData _barData() {
    return BarChartData(
      barGroups: [
        _group(0, 45000, 28000, 17000),
        _group(1, 52000, 30000, 22000),
        _group(2, 48000, 29000, 19000),
        _group(3, 60000, 32000, 28000),
      ],
      titlesData: FlTitlesData(show: false),
    );
  }

  BarChartGroupData _group(int x, double r, double c, double p) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: r, color: Colors.purple, width: 6),
      BarChartRodData(toY: c, color: Colors.orange, width: 6),
      BarChartRodData(toY: p, color: Colors.green, width: 6),
    ]);
  }
}

class _SummaryBox extends StatelessWidget {
  final String l, r;
  const _SummaryBox(this.l, this.r);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l),
        Text(r, style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String l, r;
  const _ResultRow(this.l, this.r);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(l), Text(r)],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final int num;
  final String title, sub;
  const _Step(this.num, this.title, this.sub);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.purple,
            child: Text("$num",
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sub, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;
  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(children: [
        Icon(Icons.square, color: color, size: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12))
      ]),
    );
  }
}
class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _InputField(this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (_) => (context.findAncestorStateOfType<_FinancePageState>())?.calculateROI(),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


Widget _schemeItem({
  required String title,
  required String subtitle,
  required String amount,
  required bool active,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SIDE TEXT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (active)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Active",
                        style:
                        TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Coming Soon",
                        style:
                        TextStyle(color: Colors.black87, fontSize: 11),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Text(
                amount,
                style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        /// RIGHT SIDE BUTTON
        Column(
          children: [
            ElevatedButton(
              onPressed: active ? () {} : () {},
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.black,
              ),
              child: Text(
                active ? "Apply Now" : "Learn More",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

class _GuideStep extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const _GuideStep({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.purple,
            child: Text(number,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
