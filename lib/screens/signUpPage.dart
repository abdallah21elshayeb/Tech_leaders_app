import 'package:flutter/material.dart';
import 'package:tech_test/screens/signinPage.dart';
import 'package:tech_test/services/auth_sevices.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedLocation;

  final List<String> _locations = ['Zayed', 'October', 'Mohandsen'];

  void _signUp() async {
    if (_formKey.currentState!.validate()) {

      await AuthService().signUp(email: _emailController.text, password: _passwordController.text, context: context);
      // Perform sign-up logic here
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Account created successfully!')),
      // );
      // // Example: Navigate to the home page
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const SignInPage()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Name Input
              // TextFormField(
              //   controller: _nameController,
              //   decoration: const InputDecoration(
              //     labelText: 'Name',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your name';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 16),
              // // Dropdown List for Location
              // DropdownButtonFormField<String>(
              //   value: _selectedLocation,
              //   decoration: const InputDecoration(
              //     labelText: 'Location',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: _locations.map((location) {
              //     return DropdownMenuItem(
              //       value: location,
              //       child: Text(location),
              //     );
              //   }).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedLocation = value;
              //     });
              //   },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select a location';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 16),
              // Email Input
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Password Input
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Sign Up Button
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
