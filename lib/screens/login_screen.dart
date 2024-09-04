
import 'package:clone_ig/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String dropdownValue = 'Khmer';

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('English'),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Khmer'),
              onTap: () {
                Get.updateLocale(const Locale('kh', 'KH'));
                Navigator.pop(context);
              },
            ),
            // Add more languages here
          ],
        );
      },
    );
  }

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffffedf9), Color(0xffdaeafd)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: Get.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.1),
                      TextButton(
                        onPressed: () {
                          _showLanguageBottomSheet(context);
                        },
                        child: Text('English'.tr), // Use the translation
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/image/logo-instagram.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!GetUtils.isEmail(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Color(0xFFDDDDDD),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                            ),
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          prefixIcon: const Icon(Icons.account_circle),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          isDense: true,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ), backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text;
                                  final password = _passwordController.text;
                                  controller.login(
                                    email: email,
                                    password: password,
                                  );
                                }
                              },
                              icon:
                                  const Icon(Icons.login, color: Colors.white),
                              label: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do not have an account?".tr),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => SignupScreen(),
                                transition: Transition.fadeIn,
                              );
                            },
                            child: const Text("Sign up"),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/image/Meta-Logo.png",
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
