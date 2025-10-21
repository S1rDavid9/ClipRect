import 'package:flutter/material.dart';
import '../widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple[100]!,
              Colors.blue[100]!,
              Colors.pink[100]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Text(
                      'ClipRect Demo',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [Colors.purple, Colors.blue, Colors.pink],
                          ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
                      ),
                    ),
                    const Text(
                      'Widget Showcase',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Central Image
                    Hero(
                      tag: 'central-image',
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/flutterphoto.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback if image not found
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.deepPurple,
                                      Colors.blue,
                                      Colors.cyan,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.crop_free,
                                    size: 120,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Buttons
                    GradientButton(
                      label: 'Tap & Focus Demo',
                      icon: Icons.touch_app,
                      gradientColors: const [Colors.deepPurple, Colors.purple],
                      onPressed: () {
                        Navigator.pushNamed(context, '/tap-focus');
                      },
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      label: 'Clipping Types Demo',
                      icon: Icons.image,
                      gradientColors: const [Colors.blue, Colors.cyan],
                      onPressed: () {
                        Navigator.pushNamed(context, '/clipping-demo');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}