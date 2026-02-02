import 'package:flutter/material.dart';

/// Animated Button with scale and color transition
class AnimatedButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;
  final double? width;

  const AnimatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xFFFF6B35),
    this.icon,
    this.width,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    _controller.forward();
  }

  void _onPointerUp(PointerUpEvent event) {
    _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            padding: EdgeInsets.symmetric(
              horizontal: widget.width ?? 40,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated Card with fade-in and lift effect
class AnimatedCardWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double? height;

  const AnimatedCardWidget({
    Key? key,
    required this.child,
    this.delay = const Duration(milliseconds: 0),
    this.height,
  }) : super(key: key);

  @override
  State<AnimatedCardWidget> createState() => _AnimatedCardWidgetState();
}

class _AnimatedCardWidgetState extends State<AnimatedCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Rotating Loading Indicator
class RotatingLoadingWidget extends StatefulWidget {
  final double size;
  final Color color;

  const RotatingLoadingWidget({
    Key? key,
    this.size = 60,
    this.color = const Color(0xFFFF6B35),
  }) : super(key: key);

  @override
  State<RotatingLoadingWidget> createState() => _RotatingLoadingWidgetState();
}

class _RotatingLoadingWidgetState extends State<RotatingLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(
        Icons.restaurant,
        size: widget.size,
        color: widget.color,
      ),
    );
  }
}

/// Pulsing Animation for important elements
class PulsingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PulsingWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<PulsingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}

/// Floating Action Button with bouncing animation
class AnimatedFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;
  final String tooltip;

  const AnimatedFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = const Color(0xFFFF6B35),
    this.tooltip = '',
  }) : super(key: key);

  @override
  State<AnimatedFloatingActionButton> createState() =>
      _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: FloatingActionButton(
            onPressed: widget.onPressed,
            backgroundColor: widget.backgroundColor,
            tooltip: widget.tooltip,
            child: Icon(widget.icon, color: Colors.white),
          ),
        );
      },
    );
  }
}

/// Shimmer loading effect
class ShimmerEffect extends StatefulWidget {
  final Widget child;

  const ShimmerEffect({Key? key, required this.child}) : super(key: key);

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1 - 2 * _controller.value, 0),
              end: Alignment(3 - 2 * _controller.value, 0),
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
