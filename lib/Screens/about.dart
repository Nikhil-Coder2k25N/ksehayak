import 'package:flutter/material.dart';
import 'package:ksehayak/URL/image.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const primaryGreen = Color(0xFF2E7D32);
  static const accentGreen = Color(0xFF66BB6A);
  static const lightBg = Color(0xFFF4F6F8);

  Widget sectionContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
        ],
      ),
      child: child,
    );
  }

  Widget sectionTitle(String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 22,
          decoration: BoxDecoration(
            color: primaryGreen,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: primaryGreen, size: 22),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: accentGreen),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget teamTile(String name, String role, String desc, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: lightBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: primaryGreen,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                Text(role,
                    style: const TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontSize: 13)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryGreen, accentGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: Center(
              child: Text(
                "About Smart Safron",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            sectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("About Smart Safron", Icons.eco),
                  const SizedBox(height: 10),
                  const Text(
                    "Smart Safron is an agri-tech mobile application designed to modernize saffron farming using smart technology. "
                        "It helps farmers monitor crop conditions in real time and make better decisions to improve yield and reduce losses.",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            sectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Our Mission", Icons.flag),
                  bullet("Support farmers with real-time agricultural data"),
                  bullet("Reduce crop damage through early alerts"),
                  bullet("Improve saffron yield and quality"),
                  bullet("Promote sustainable farming practices"),
                ],
              ),
            ),

            sectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Our Team", Icons.group),

                  teamTile(
                    "Ishan Shrivastava",
                    "Co-Founder & Research Lead",
                    "Leads agricultural research, field strategy, and startup direction for Smart Safron.",
                    AppImageModel.Ishan.Images,
                  ),

                  teamTile(
                    "Nikhil Singh Bhati",
                    "App Developer & IoT Integration",
                    "Flutter development and IoT-based smart farming solutions.",
                    AppImageModel.Nikhil.Images,
                  ),

                  teamTile(
                    "Divyansh Jain",
                    "Backend & Technical Support",
                    "Backend systems and smart monitoring integration.",
                    AppImageModel.Divyansh.Images,
                  ),
                  // teamTile(
                  //   "Jatin Rajput",
                  //   "Quality Tester",
                  //   "Responsible for testing app performance and ensuring a smooth & reliable experience.",
                  //   AppImageModel.Jatin.Images,
                  // ),
                ],
              ),
            ),


            sectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Privacy & Data Policy", Icons.lock),
                  bullet("Only farming-related environmental data is collected"),
                  bullet("Personal data is never shared without permission"),
                  bullet("Data is used only for monitoring and alerts"),
                  bullet("We do not sell user information"),
                ],
              ),
            ),

            sectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Contact & Support", Icons.support_agent),
                  contactRow(Icons.email, "support@smartsafron.com"),
                  contactRow(Icons.phone, "+91-98765-43210"),
                  contactRow(Icons.help_outline, "Support via in-app help section"),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Text("© 2026 Smart Safron",
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
