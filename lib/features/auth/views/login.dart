import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/auth/views/register.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/features/consumer/views/home.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final localStorage = LocalStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isChecked = false;
  bool _obscureText = true;
  bool _isLoggedIn = false;

  List userDetails = [];

  _isFilled(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter information';
    }
    return null;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<int> _login(String email, String password) async {
    Map<String, String> credentials = {'email': email, 'password': password};
    int status = await HTTPHandler().postData('/login', credentials);
    List res = await HTTPHandler().postDataRes('/login', credentials);
    int _status = int.parse(status.toString());
    if (_status == 200) {
      if (_isChecked){
        localStorage.setIsLoggedIn(true);
      }
      //save user_details
      setState(() {
        userDetails = res;
      });
      _saveUserDetails(userDetails);
    }
    return _status;
  }

  Future<void> _saveUserDetails(userDetails) async {
    Map<String, String> _userDetails = {};
    for (var entry in userDetails[0].entries) {
      if (entry.value is String) {
        _userDetails[entry.key] = entry.value;
      }
      await localStorage.setUserParam(entry.key, entry.value);
    }

  }

  Future<void> _getUser() async {
    if (await localStorage.getIsLoggedIn()) {
      setState(() {
        _isLoggedIn = true;
      });
      _getUserDetails(userDetails);
    }
  }

  Future<void> _getUserDetails(userDetails) async {
    print("User");
    var user_d = await localStorage.getUserParam('id');
    print(user_d);
  }

  @override
  void initState() {
    HTTPHandler().getData('/');
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? const HomePage()
        : Scaffold(
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
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) => _isFilled(value),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                labelText: "Email address",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              validator: (value) => _isFilled(value),
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.key_rounded),
                                labelText: "Password",
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _toggleObscureText();
                                  },
                                  child: _obscureText
                                      ? const Icon(Icons.remove_red_eye_sharp)
                                      : const Icon(Icons.remove),
                                ),
                                border: const OutlineInputBorder(),
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
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    int status = await _login(
                                        emailController.text,
                                        passwordController.text);
                                    if (!context.mounted) return;
                                    if (status == 200) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                    } else {
                                      final snackBar = SnackBar(
                                        content: const Text(
                                            "Wrong email or password!"),
                                        backgroundColor: Colors.red.shade900,
                                        action: SnackBarAction(
                                            label: "Try again",
                                            onPressed: () {}),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                },
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
                                onPressed: () => Navigator.pushReplacement(
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
