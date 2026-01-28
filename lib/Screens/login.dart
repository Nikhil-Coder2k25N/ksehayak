import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/BottomNavigation.dart';
import 'package:ksehayak/URL/image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  String selectedRole = "Partner";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(1),
          child: Container(
            width: 380,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFFFBEBE),
                width: 3,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// LOGO
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFB721FF), Color(0xFFFAD961)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  //URL 💀
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.network(
                      AppImageModel.appLogo.Images,
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  "Smart Saffron Farming",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Revolutionizing saffron cultivation with IoT & AI",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                /// LOGIN / SIGNUP TOGGLE
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      _toggleButton("Login", true),
                      _toggleButton("Sign Up", false),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// FULL NAME (SIGNUP ONLY)
                if (!isLogin)
                  _inputField(
                    label: "Full Name",
                    hint: "",
                  ),

                /// ROLE
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Your Role",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),

                _roleOption("Farmer"),
                _roleOption("Investor"),
                _roleOption("Partner"),

                const SizedBox(height: 10),

                /// EMAIL
                _inputField(
                  label: "Email",
                  hint: " ",
                ),

                /// PASSWORD
                _inputField(
                  label: "Password",
                  hint: "",
                  isPassword: true,
                ),

                const SizedBox(height: 20),

                /// BUTTON
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F0C29), Color(0xFF302B63)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InternalPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.eco_outlined, color: Colors.white,size: 25,),
                        const SizedBox(width: 8),
                        Text(
                          isLogin ? "Login" : "Create Account",
                          style: const TextStyle(
                            fontSize: 16,color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// TOGGLE BUTTON
  Widget _toggleButton(String text, bool loginTab) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => isLogin = loginTab);
        },
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isLogin == loginTab ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isLogin == loginTab ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ROLE RADIO
  Widget _roleOption(String role) {
    return RadioListTile(
      value: role,
      groupValue: selectedRole,
      onChanged: (value) {
        setState(() => selectedRole = value.toString());
      },
      title: Text(role),
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  /// INPUT FIELD
  Widget _inputField({
    required String label,
    required String hint,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
