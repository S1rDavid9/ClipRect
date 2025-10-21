import 'package:flutter/material.dart';
import 'dart:ui';
import '../widgets/back_button_widget.dart';

class TapFocusScreen extends StatefulWidget {
  const TapFocusScreen({Key? key}) : super(key: key);

  @override
  State<TapFocusScreen> createState() => _TapFocusScreenState();
}

class _TapFocusScreenState extends State<TapFocusScreen>
    with SingleTickerProviderStateMixin {
  Offset? _focusPoint;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final GlobalKey _imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap(TapDownDetails details) {
    final RenderBox? renderBox = _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPosition = renderBox.globalToLocal(details.globalPosition);
    final size = renderBox.size;

    if (localPosition.dx >= 0 &&
        localPosition.dx <= size.width &&
        localPosition.dy >= 0 &&
        localPosition.dy <= size.height) {
      setState(() {
        _focusPoint = localPosition;
      });
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[50]!, Colors.blue[50]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const BackButtonWidget(),
                    const SizedBox(width: 16),
                    const Text(
                      'Tap & Focus Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Instruction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.purple),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Tap anywhere on the image to focus on that area!',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              
              Expanded(
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final imageSize = Size(
                        constraints.maxWidth * 0.9,
                        constraints.maxHeight * 0.8,
                      );

                      return GestureDetector(
                        onTapDown: _handleTap,
                        child: Container(
                          key: _imageKey,
                          width: imageSize.width,
                          height: imageSize.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                // Background blurred image
                                ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: _focusPoint != null ? 10 : 0,
                                    sigmaY: _focusPoint != null ? 10 : 0,
                                  ),
                                  child: _buildDemoImage(imageSize),
                                ),

                                
                                if (_focusPoint != null)
                                  AnimatedBuilder(
                                    animation: _scaleAnimation,
                                    builder: (context, child) {
                                      return Positioned(
                                        left: _focusPoint!.dx - 75,
                                        top: _focusPoint!.dy - 75,
                                        child: Transform.scale(
                                          scale: _scaleAnimation.value,
                                          child: Container(
                                            width: 150,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 4,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.purple
                                                      .withOpacity(0.6),
                                                  blurRadius: 15,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: ClipRect(
                                                child: OverflowBox(
                                                  minWidth: imageSize.width,
                                                  maxWidth: imageSize.width,
                                                  minHeight: imageSize.height,
                                                  maxHeight: imageSize.height,
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                      -(_focusPoint!.dx - 75),
                                                      -(_focusPoint!.dy - 75),
                                                    ),
                                                    child:
                                                        _buildDemoImage(imageSize),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildDemoImage(Size size) {
    return Image.asset(
      'assets/photo3.webp',
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Fallback gradient if image not found
        return Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange,
                Colors.pink,
                Colors.purple,
                Colors.blue,
                Colors.cyan,
                Colors.green,
              ],
            ),
          ),
          child: CustomPaint(
            painter: PatternPainter(),
          ),
        );
      },
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawCircle(Offset(i, i), 20, paint);
      canvas.drawCircle(Offset(size.width - i, i), 20, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
