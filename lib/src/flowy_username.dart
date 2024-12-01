import 'package:flutter/material.dart';

class FlowyUsernamePage extends StatefulWidget {
  const FlowyUsernamePage({super.key});

  @override
  State<FlowyUsernamePage> createState() => _FlowyUsernamePageState();
}

class _FlowyUsernamePageState extends State<FlowyUsernamePage> {
  late TextEditingController firstNameController;
  double round = 7;
  late RegExp firstLastNameRegex;
  bool first = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    firstLastNameRegex = RegExp(r'^[a-zA-Z]+$');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  bool _isValidFirstName(String value) {
    return firstLastNameRegex.hasMatch(value) && value.length <= 20;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0, end: 0.166666666667),
              builder: (context, value, _) => Container(
                height: 4,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 20),
                    // Title
                    const Text(
                      'What\'s your name?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your first name to get started',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // First Name Field
                    TextFormField(
                      controller: firstNameController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(round),
                        ),
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: firstNameController.text.isNotEmpty,
                        fillColor: _isValidFirstName(firstNameController.text)
                            ? Colors.white
                            : Colors.red.shade50,
                        errorText: firstNameController.text.isNotEmpty &&
                                !_isValidFirstName(firstNameController.text)
                            ? firstNameController.text.length > 20
                                ? 'First name must be 20 characters or less'
                                : 'First name can only contain letters'
                            : null,
                        counterText: '',
                      ),
                      onChanged: (value) {
                        setState(() {
                          first = value.isNotEmpty;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                    ),
                  ],
                ),
              ),
            ),
            // Continue Button
            Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 0, 20, MediaQuery.of(context).viewInsets.bottom + 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      first && _isValidFirstName(firstNameController.text)
                          ? () {}
                          : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(round),
                    ),
                    backgroundColor:
                        first && _isValidFirstName(firstNameController.text)
                            ? Colors.green
                            : Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
