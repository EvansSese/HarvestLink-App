import 'package:flutter/material.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              largeTextBlack("Let's create your account"),
              const SizedBox(height: 32.0),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              labelText: "First name",
                              prefixIcon: Icon(Icons.account_circle),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              labelText: "Last name",
                              prefixIcon: Icon(Icons.account_circle),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Email address",
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Location",
                        prefixIcon: Icon(Icons.pin_drop),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Create Password",
                        prefixIcon: Icon(Icons.key_rounded),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.key_rounded),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
