import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/BottomNavigation.dart';
import 'package:ksehayak/URL/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool isLoading = false;

  Future<String> generateUserId(String role) async {
    try {
      String prefix;

      if (role == "Farmer") {
        prefix = "FAR";
      } else if (role == "Partner") {
        prefix = "PAR";
      }
      else {
        prefix = "INV";
      }

      final counterRef = _firestore.collection("Counters").doc(role);

      return await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(counterRef);

        int newNumber = 1;

        if (snapshot.exists && snapshot.data() != null) {
          newNumber = (snapshot["lastId"] ?? 0) + 1;
        }

        transaction.set(counterRef, {"lastId": newNumber});

        String year = DateTime.now().year.toString();
        String formattedNumber = newNumber.toString().padLeft(3, '0');

        String newId = "$prefix$year$formattedNumber";

        print("Generated User ID: $newId"); // 🔍 DEBUG LOG

        return newId;
      });

    } catch (e) {
      print("ID GENERATION ERROR: $e");
      rethrow;
    }
  }


  //Auth Credential
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    try {
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      DocumentSnapshot userDoc =
      await _firestore.collection("KisanSehayak").doc(uid).get();

      if (!userDoc.exists) {
        showError("User profile not found");
        await _auth.signOut();
        return;
      }

      String firestoreRole = userDoc["role"];

      // 🔥 ROLE CHECK
      if (firestoreRole != selectedRole) {
        await _auth.signOut();
        showError("You are registered as $firestoreRole, not $selectedRole");
        return;
      }

      print("Login successful as $firestoreRole");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => InternalPage()),
      );

    } on FirebaseAuthException catch (e) {
      showError(e.message ?? "Login Failed");
    } catch (e) {
      showError("Something went wrong");
    }
  }
  Future<void> signUpUser() async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user!;

      await user.updateDisplayName(nameController.text.trim());

      // 🔄 Refresh auth state
      await user.reload();
      final refreshedUser = _auth.currentUser!;

      // 🔥 Generate custom user ID
      String customUserId = await generateUserId(selectedRole);

      // 🔥 Save user profile in Firestore
      await _firestore.collection("KisanSehayak").doc(refreshedUser.uid).set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "role": selectedRole,
        "uid": refreshedUser.uid,
        "userId": customUserId,
        "createdAt": FieldValue.serverTimestamp(),
      });

      print("USER PROFILE SAVED WITH ID: $customUserId");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => InternalPage()),
      );

    } on FirebaseAuthException catch (e) {
      showError(e.message ?? "Signup Failed");
    } catch (e) {
      print("SIGNUP FIRESTORE ERROR: $e");
      showError("Error saving profile");
    }
  }
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }



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
                    controller: nameController,
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
                  hint: "",
                  controller: emailController,
                ),

                /// PASSWORD
                _inputField(
                  label: "Password",
                  hint: "",
                  isPassword: true,
                  controller: passwordController,
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
                    onPressed: isLoading
                        ? null
                        : () async {
                      setState(() => isLoading = true);

                      if (isLogin) {
                        await loginUser();
                      } else {
                        await signUpUser();
                      }

                      if (mounted) {
                        setState(() => isLoading = false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.eco_outlined, color: Colors.white, size: 25),
                        const SizedBox(width: 8),
                        Text(
                          isLogin ? "Login" : "Create Account",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
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
