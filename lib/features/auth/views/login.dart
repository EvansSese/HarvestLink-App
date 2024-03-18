import 'package:flutter/material.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';
import 'package:harvestlink_app/templates/constants/spacing.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(image: AssetImage(HLImage.hLogo)),
                  headerTextBlack("Welcome Back"),
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
                                value: true,
                                activeColor: Colors.green.shade900,
                                onChanged: (value) {},
                              ),
                              smallTextBlack("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: smallTextBlack("Forgot password"),
                          )
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
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
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              shape: const ContinuousRectangleBorder()),
                          child: largeTextBlack("Create account"),
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
