import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/features/auth/views/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final localStorage = LocalStorage();
  String _name = '';
  String _location = '';
  String _email = '';
  String _phone = '';
  String _userType = '';

  void _getUserDetails() async {
    var userName = await localStorage.getUserParam('name');
    var userEmail = await localStorage.getUserParam('email');
    var userLocation = await localStorage.getUserParam('location');
    var userPhone = await localStorage.getUserParam('phone');
    var userType = await localStorage.getUserParam('user_type');
    setState(() {
      _name = userName!;
      _location = userLocation!;
      _email = userEmail!;
      _phone = userPhone!;
      _userType = userType!;
    });

  }

  Future<void> _logOut() async {
    await localStorage.setIsLoggedIn(false);
    _getUserDetails();
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 100.0,
                      color: Colors.green.shade900,
                    ),
                  ),
                ),
                Text(
                  _name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  _location,
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 20.0),
            const Text(
              "Your Details",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.green.shade900,
                  child: const Icon(Icons.phone_android_outlined)),
              title: Text(_phone),
              subtitle: const Text("Phone number"),
              trailing: Icon(
                Icons.check_circle,
                color: Colors.green.shade800,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.green.shade900,
                  child: const Icon(Icons.email_outlined)),
              title: Text(_email),
              subtitle: const Text("Email address"),
              trailing: Icon(
                Icons.check_circle,
                color: Colors.green.shade800,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.green.shade900,
                  child: const Icon(Icons.account_box_rounded)),
              title: Text(_userType),
              subtitle: const Text("Account type"),
              trailing: Icon(
                Icons.check_circle,
                color: Colors.green.shade800,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: OutlinedButton(
                  onPressed: () {
                    localStorage.setIsLoggedIn(false);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const LoginScreen()));
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.green.shade900),
                      shape: const StadiumBorder(),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.green.shade900,
                      minimumSize: const Size(200.0, 40.0)),
                  child: const Text("Logout")),
            ),
          ],
        ),
      ),
    );
  }
}
