import 'package:flutter/material.dart';

class FlowyUsernamePage extends StatefulWidget {
  const FlowyUsernamePage({
    super.key,
    this.title = "What's your name?",
    this.subtitle = "Enter your first name to get started",
    this.fieldLabel = "First Name",
    this.prefixIcon = const Icon(Icons.person_outline),
    this.suffixIcon,
    this.backIcon = const Icon(Icons.arrow_back),
    this.maxLength = 20,
    this.validationRegex = r'^[a-zA-Z]+$',
    this.regexErrorMessage = 'First name can only contain letters',
    this.lengthErrorMessage = 'First name must be 20 characters or less',
    this.continueButtonText = 'Continue',
    this.onContinue,
    this.buttonColor = Colors.green,
    this.progressBarColor,
    this.cornerRadius = 7.0,
  });

  final String title;
  final String subtitle;
  final String fieldLabel;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Widget backIcon;
  final int maxLength;
  final String validationRegex;
  final String regexErrorMessage;
  final String lengthErrorMessage;
  final String continueButtonText;
  final void Function(String value)? onContinue;
  final Color buttonColor;
  final Color? progressBarColor;
  final double cornerRadius;

  @override
  State<FlowyUsernamePage> createState() => _FlowyUsernamePageState();
}

class _FlowyUsernamePageState extends State<FlowyUsernamePage> {
  late TextEditingController firstNameController;
  late RegExp firstLastNameRegex;
  bool first = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    firstLastNameRegex = RegExp(widget.validationRegex);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  bool _isValidFirstName(String value) {
    return firstLastNameRegex.hasMatch(value) && value.length <= widget.maxLength;
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
                        widget.progressBarColor ?? Theme.of(context).primaryColor),
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
                      icon: widget.backIcon,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 20),
                    // Title
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // First Name Field
                    TextFormField(
                      controller: firstNameController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: widget.maxLength,
                      decoration: InputDecoration(
                        labelText: widget.fieldLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(widget.cornerRadius),
                        ),
                        prefixIcon: widget.prefixIcon,
                        suffixIcon: widget.suffixIcon,
                        filled: firstNameController.text.isNotEmpty,
                        fillColor: _isValidFirstName(firstNameController.text)
                            ? Colors.white
                            : Colors.red.shade50,
                        errorText: firstNameController.text.isNotEmpty &&
                                !_isValidFirstName(firstNameController.text)
                            ? firstNameController.text.length > widget.maxLength
                                ? widget.lengthErrorMessage
                                : widget.regexErrorMessage
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
                  onPressed: first && _isValidFirstName(firstNameController.text)
                      ? () => widget.onContinue?.call(firstNameController.text)
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                    ),
                    backgroundColor:
                        first && _isValidFirstName(firstNameController.text)
                            ? widget.buttonColor
                            : Colors.grey.shade300,
                  ),
                  child: Text(
                    widget.continueButtonText,
                    style: const TextStyle(
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
