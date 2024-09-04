
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(AuthController());
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
                      const Spacer(),
                      Stack(
                        children: [
                          GetBuilder<AuthController>(
                            builder: (controller) {
                              if (_controller.profileImage != null) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 6,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: FileImage(
                                      _controller.profileImage!,
                                    ),
                                  ),
                                );
                              } else {
                                return const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://pbs.twimg.com/profile_images/1090548687359619072/t5mTtRsn_400x400.jpg",
                                  ),
                                  radius: 70,
                                );
                              }
                            },
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  _controller.selectProfileImage();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your username";
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
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          prefixIcon: const Icon(Icons.account_circle),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<AuthController>(
                        builder: (_) => TextFormField(
                          controller: _passwordController,
                          obscureText: _controller.isHidden,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Color(0xFFDDDDDD),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                              ),
                            ),
                            labelText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                _controller.toggleVisibility();
                              },
                              icon: Icon(
                                _controller.isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            prefixIcon: const Icon(Icons.password),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _controller.isHidden,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your confirm password";
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
                              labelText: "Confirm Password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _controller.toggleVisibility();
                                },
                                icon: Icon(
                                  _controller.isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              prefixIcon: const Icon(Icons.password),
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final username = _usernameController.text;
                                  final email = _emailController.text;
                                  final password = _passwordController.text;
                                  final password_confirmation =
                                      _confirmPasswordController.text;

                                  _controller.signup(
                                    name: username,
                                    email: email,
                                    password: password,
                                    password_confirmation:
                                        password_confirmation,
                                  );
                                }
                              },
                              icon:
                                  const Icon(Icons.login, color: Colors.white),
                              label: const Text(
                                "SignUp",
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
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Login"),
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
