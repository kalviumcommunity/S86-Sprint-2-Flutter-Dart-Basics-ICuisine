import 'package:flutter/material.dart';
import '../animations/animated_widgets.dart';
import '../animations/page_transitions.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFF6B35), // Vibrant orange
              const Color(0xFFFF8C42), // Light orange
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Section - Logo and Title with animations
              Expanded(
                flex: 3,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Icon/Logo with rotating animation
                        PulsingWidget(
                          duration: const Duration(milliseconds: 2000),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.restaurant_menu,
                              size: 70,
                              color: const Color(0xFFFF6B35),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // App Name with fade animation
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 800),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                          child: const Text('iCuisine'),
                        ),
                        const SizedBox(height: 10),
                        // Tagline
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 800),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                          ),
                          child: const Text('Smart Orders, Happy Customers'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Middle Section - Features
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildFeatureItem(
                        Icons.speed,
                        'Fast Order Processing',
                      ),
                      const SizedBox(height: 20),
                      _buildFeatureItem(
                        Icons.queue,
                        'No More Long Queues',
                      ),
                      const SizedBox(height: 20),
                      _buildFeatureItem(
                        Icons.check_circle_outline,
                        'Better Order Management',
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Section - CTA Buttons with animations
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Get Started Button with animation
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: AnimatedButton(
                          label: 'Get Started',
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlidePageRoute(page: const LoginScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Sign In Button with scale animation
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _controller,
                            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                SlidePageRoute(page: const LoginScreen()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
