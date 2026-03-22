import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksehayak/Screens/BottomNavigation.dart';
import 'package:ksehayak/Screens/login.dart';
import 'package:ksehayak/URL/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDrawerUI extends StatefulWidget {
  const ProfileDrawerUI({super.key});

  @override
  State<ProfileDrawerUI> createState() => _ProfileDrawerUIState();
}

class _ProfileDrawerUIState extends State<ProfileDrawerUI> {

  bool isLoggingOut = false;

  String name = "Loading...";
  String userId = "Loading...";
  String role = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("KisanSehayak")
          .doc(uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc["name"] ?? "No Name";
          userId = userDoc["userId"] ?? "No ID";
          role = userDoc["role"] ?? "No Role";
        });
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
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
            color: const Color(0xFF9F4F00),
            padding: const EdgeInsets.only(top: 20, left: 8, right: 5),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.network(
                      AppImageModel.Profile1.Images,
                      height: 70,
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
                      Text(userId, style: const TextStyle(color: Colors.white)),
                      Text(
                        role,
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
                _menuItem(Icons.dashboard_outlined, "Dashboard", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternalPage(initialIndex: 0),
                    ),
                  );
                }),
                _menuItem(Icons.shopping_cart, "Store", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternalPage(initialIndex: 3),
                    ),
                  );
                }),
                _menuItem(Icons.settings, "Control", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternalPage(initialIndex: 1),
                    ),
                  );
                }),
                _menuItem(Icons.trending_up_outlined, "Monitor", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternalPage(initialIndex: 2),
                    ),
                  );
                }),
                _menuItem(Icons.currency_rupee, "Finance", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InternalPage(initialIndex: 4),
                    ),
                  );
                }),
                _menuItem(
                  Icons.support_agent_outlined,
                  "Support",
                      () {
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
                    border: Border.all(color: Colors.green, width: 1),
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
                            Text(
                              "support@kisansehayak.in",
                              style: GoogleFonts.abel(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            ),
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
                    onTap: isLoggingOut
                        ? null
                        : () async {
                      setState(() => isLoggingOut = true);

                      await FirebaseAuth.instance.signOut();

                      if (!mounted) return;

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                            (_) => false,
                      );
                    },
                    child: Center(
                      child: isLoggingOut
                          ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                          : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_outlined, size: 20, color: Colors.red),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ],
                      ),
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

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF9F4F00)),
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
