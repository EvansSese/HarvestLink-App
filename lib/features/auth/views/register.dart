import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/features/auth/views/login.dart';
import 'package:harvestlink_app/features/consumer/views/home.dart';
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
  final phoneController = TextEditingController();
  String accTypeController = "";
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

  Future<int> _signup(String name, String accountType, String location,
      String email, String phone, String password) async {
    Map<String, String> credentials = {
      'name': name,
      'email': email,
      'phone': phone,
      'account_type': accountType,
      'location': location,
      'password': password
    };
    print(credentials);
    int status = await HTTPHandler().postData('/signup', credentials);
    return int.parse(status.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              subHeaderTextBlack("Let's create your account"),
              const SizedBox(height: 32.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: fNameController,
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
                            controller: lNameController,
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
                      controller: emailController,
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
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) => _isFilled(value),
                      expands: false,
                      decoration: const InputDecoration(
                        hintText: 'E.g 07xxxxxxxx',
                        labelText: "Phone number",
                        prefixIcon: Icon(Icons.phone),
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
                      onChanged: (item) {
                        accTypeController = item!;
                      },
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
                      controller: locationController,
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
                      controller: passwordController,
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
                      controller: confirmPasswordController,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red.shade900,
                                  action: SnackBarAction(
                                      label: "Try again", onPressed: () {}),
                                  content:
                                      const Text('Passwords do not match!'),
                                ),
                                //register function
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green.shade900,
                                  content:
                                      const Text('Creating your account...'),
                                ),
                              );
                              var name =
                                  '${fNameController.text} ${lNameController.text}';
                              int status = await _signup(
                                  name,
                                  accTypeController.toLowerCase(),
                                  locationController.text,
                                  emailController.text,
                                  phoneController.text,
                                  passwordController.text);
                              if (!context.mounted) return;
                              if (status == 201) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green.shade900,
                                    content: const Text(
                                        'Account created successfully'),
                                  ),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            const LoginScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red.shade900,
                                    content:
                                        const Text('Error creating account'),
                                  ),
                                );
                              }
                            }
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
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen())),
                        style: OutlinedButton.styleFrom(
                            shape: const ContinuousRectangleBorder()),
                        child: mediumTextBlack("Login"),
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
