import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksehayak/Screens/BottomNavigation.dart';
import 'package:ksehayak/Screens/login.dart';
import 'package:ksehayak/URL/image.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDrawerUI extends StatelessWidget {
  const ProfileDrawerUI({super.key});

  // Initial Letter
  String getInitial(String name) {
    if (name.trim().isEmpty) return "?";
    return name.trim()[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 STATIC UI DATA (Replace later)
    const String name = "NIKHIL S BHATI";
    const String staffId = "DEV2025";
    const String subject = "Developer";

    return Drawer(
      backgroundColor: Colors.white,
      elevation: 20,
      width: 320,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// HEADER
          Container(
            height: 150,
            width: double.infinity,
            color: Color(0xFF9F4F00),
            padding: const EdgeInsets.only(top: 20, left: 8, right: 5),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  // child: CircleAvatar(
                  //   radius: 38,
                  //   backgroundColor: const Color(0xff2d49bf),
                  //   child: Text(
                  //     getInitial(name),
                  //     style: const TextStyle(
                  //       fontSize: 40,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.network(
                      height: 70,
                      AppImageModel.Profile1.Images,
                      //color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        staffId,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        subject,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// MENU
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _menuItem(
                  icon: Icons.dashboard_outlined,
                  title: "Dashboard",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternalPage(initialIndex: 0),
                      ),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.shopping_cart,
                  title: "Store",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternalPage(initialIndex: 3),
                      ),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.settings,
                  title: "Control",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternalPage(initialIndex: 1),
                      ),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.trending_up_outlined,
                  title: "Monitor",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternalPage(initialIndex: 2),
                      ),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.currency_rupee,
                  title: "Finance",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternalPage(initialIndex: 4),
                      ),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.support_agent_outlined,
                  title: "Support",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InternalPage(initialIndex: 4),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// SUPPORT BOX
                Container(
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green,width: 1),
                    color: const Color(0xE1D3F1C9),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Text(
                              "Technical Support",
                              style: GoogleFonts.aBeeZee(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            const Icon(CupertinoIcons.mail,
                                color: Color(0xFF9F4F00), size: 20),
                            const SizedBox(width: 10),
                            Text("support@kisansehayak.in",style:GoogleFonts.abel(fontSize: 18,decoration: TextDecoration.underline),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// LOGOUT
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0x1F843030),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                            (_) => false,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_outlined,
                            size: 20, color: Colors.red),
                        SizedBox(width: 10),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MENU ITEM WIDGET
  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF9F4F00)),
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
