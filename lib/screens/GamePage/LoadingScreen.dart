import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class LoadingScreen extends StatefulWidget {
  final String levelHint; // This will now be the "Did you know?" text
  final VoidCallback onComplete;

  const LoadingScreen({
    Key? key,
    required this.levelHint,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to call onComplete after a delay, e.g., 3 seconds
    // Adjust duration as needed
    _timer = Timer(const Duration(seconds: 31), () {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Removed _skip method as there's no skip button in the new design

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF215B7C), // Updated background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align to start for more control
            children: [
              const SizedBox(height: 50), // Space from the top
              // Image in the top section
              Image.asset(
                'assets/image/udin.jpeg', // Path to your image
                height: 200, // Adjust height as needed
                // You might need to adjust width or BoxFit depending on the image aspect ratio
                // For a character, BoxFit.contain is often good.
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 50), // Space between image and text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/bird_icon.png', // Replace with your bird icon path
                    width: 24,
                    height: 24,
                    color: Colors.white, // Assuming a white bird icon as in the image
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if bird_icon.png is not found
                      return const Icon(Icons.lightbulb_outline, color: Colors.white, size: 24);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "“Did you know?”",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16), // Space between "Did you know" and the hint
              // The main hint text
              Text(
                widget.levelHint,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.5, // Line spacing
                  // fontWeight: FontWeight.w500, // Removed for slightly lighter appearance
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(), // Pushes content upwards
              // No "Skip" button or CircularProgressIndicator as per the image
            ],
          ),
        ),
      ),
    );
  }
}
