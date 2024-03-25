import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/auth/views/login.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final accTypeController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isChecked = false;

  _isFilled(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter information';
    }
    return null;
  }

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
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) => _isFilled(value),
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
                            validator: (value) => _isFilled(value),
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
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      validator: (value) => _isFilled(value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Email address",
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    DropdownButtonFormField(
                      validator: (value) => _isFilled(value),
                      decoration: const InputDecoration(
                        labelText: "Choose account type",
                        prefixIcon: Icon(Icons.account_box_rounded),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (item) {},
                      hint: const Text("Register as..."),
                      items: <String>['Farmer', 'Consumer'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      validator: (value) => _isFilled(value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Location",
                        prefixIcon: Icon(Icons.pin_drop),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      validator: (value) => _isFilled(value),
                      expands: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Create Password",
                        prefixIcon: Icon(Icons.key_rounded),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      validator: (value) => _isFilled(value),
                      expands: false,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.key_rounded),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
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
                        smallTextBlack("I agree to the "),
                        Text(
                          "Terms and conditions",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900,
                            shape: const ContinuousRectangleBorder()),
                        child: largeTextWhite("Register"),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen())),
                        style: OutlinedButton.styleFrom(
                            shape: const ContinuousRectangleBorder()),
                        child: mediumTextBlack("Login instead"),
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
