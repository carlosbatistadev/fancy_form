import 'package:example/great_form.dart';
import 'package:fancy_form/fancy_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Form Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SimpleFormScreen(),
    );
  }
}

class SimpleFormScreen extends StatefulWidget {
  const SimpleFormScreen({super.key});

  @override
  State<SimpleFormScreen> createState() => _SimpleFormScreenState();
}

class _SimpleFormScreenState extends State<SimpleFormScreen> {
  final greatForm = GreatForm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FancyForm(
          fancyManager: greatForm,
          child: ListView(
            children: [
              FancyFormField(
                fancyKey: FancyKey(
                  id: 'name',
                  formManager: greatForm,
                ),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
              ),
              SizedBox(height: 16),
              FancyFormField(
                fancyKey: FancyKey(
                  id: 'fullName',
                  formManager: greatForm,
                ),
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 16),
              FancyFormField(
                fancyKey: FancyKey(
                  id: 'phoneNumber',
                  formManager: greatForm,
                ),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                // keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              FancyFormField(
                fancyKey: FancyKey(
                  id: 'address',
                  formManager: greatForm,
                ),
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                ),
              ),
              SizedBox(height: 16),
              FancyFormField(
                fancyKey: FancyKey(
                  id: 'notes',
                  formManager: greatForm,
                ),
                decoration: InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Enter any notes',
                ),
                maxLines: 4,
              ),
              SizedBox(
                height: 12,
              ),
              FilledButton(
                onPressed: () {
                  if (greatForm.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Form validated successfuly'),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
