import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/auth/views/register.dart';
import 'package:harvestlink_app/navigation_bar.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(image: AssetImage(HLImage.hLogo)),
                  headerTextBlack("Welcome"),
                  const SizedBox(
                    height: 22.0,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Email address",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.key_rounded),
                          labelText: "Password",
                          suffixIcon: Icon(Icons.remove_red_eye_sharp),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                activeColor: Colors.green.shade900,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isChecked = newValue!;
                                  });
                                },
                              ),
                              smallTextBlack("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: smallTextBlack("Forgot password?"),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const NavigationMenu())),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade900,
                              shape: const ContinuousRectangleBorder()),
                          child: largeTextWhite("Sign In"),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen())),
                          style: OutlinedButton.styleFrom(
                              shape: const ContinuousRectangleBorder()),
                          child: largeTextBlack("Register"),
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
    );
  }
}
