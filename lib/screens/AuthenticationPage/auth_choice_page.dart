import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learningflutter/screens/AuthenticationPage/SignIn_page.dart';
import 'package:learningflutter/screens/AuthenticationPage/SignUp_page.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Main content
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title text
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      children: [
                        const TextSpan(text: 'Want to track your '),
                        TextSpan(
                          text: 'Quran',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(25, 101, 128, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: '\nprogress?'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Subtitle
                  Row(
                    children: [
                      Text(
                        'new to ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'HifzAI',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(25, 101, 128, 1),
                        ),
                      ),
                      Icon(Icons.question_mark)
                      
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Sign Up Button
                  
                  Container(
                    decoration: BoxDecoration(
                    boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 8), // x = 0, y = 8
                                blurRadius: 12,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color.fromRGBO(25, 101, 128, 1),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                  
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 3,
                    color: const Color.fromARGB(119, 0, 0, 0),
                  ),
                  const SizedBox(height: 16,),
                  // Already have account text
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Container(
                    decoration: BoxDecoration(
                    boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(0, 8), // x = 0, y = 8
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SigninPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color.fromRGBO(25, 101, 128, 1),
                                
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 302),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}