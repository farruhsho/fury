import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 🔥 Fury Chat Neon Components
/// Reusable UI components with neon-glass aesthetic
class NeonComponents {
  
  /// Glass morphism container
  static Widget glassContainer({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double borderRadius = 16,
    double blur = 20,
    Color? borderColor,
    List<BoxShadow>? shadows,
  }) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: FuryColors.glassGradient,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: shadows,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
  
  /// Primary neon button with flame gradient
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    double height = 56,
    double borderRadius = 16,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        decoration: BoxDecoration(
          gradient: FuryColors.flameGradient,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: FuryColors.neonPinkGlow(intensity: 0.8),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    );
  }
  
  /// Ghost button with neon border
  static Widget ghostButton({
    required String text,
    required VoidCallback onPressed,
    Color borderColor = FuryColors.neonPink,
    double height = 56,
    double borderRadius = 16,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: borderColor.withValues(alpha: 0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: borderColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
  
  /// Neon text field
  static Widget neonTextField({
    required TextEditingController controller,
    String? hintText,
    IconData? prefixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Color focusColor = FuryColors.neonPink,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isFocused = false;
        
        return Focus(
          onFocusChange: (focused) => setState(() => isFocused = focused),
          child: Builder(
            builder: (context) {
              final hasFocus = Focus.of(context).hasFocus;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: FuryColors.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasFocus ? focusColor : FuryColors.glassLight,
                    width: hasFocus ? 2 : 1,
                  ),
                  boxShadow: hasFocus
                      ? [
                          BoxShadow(
                            color: focusColor.withValues(alpha: 0.3),
                            blurRadius: 15,
                          ),
                        ]
                      : null,
                ),
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: const TextStyle(color: FuryColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(color: FuryColors.textMuted),
                    prefixIcon: prefixIcon != null
                        ? Icon(prefixIcon, color: FuryColors.textMuted)
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  
  /// Neon icon button
  static Widget neonIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color color = FuryColors.neonPink,
    double size = 48,
    bool showGlow = true,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          boxShadow: showGlow
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ]
              : null,
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }
  
  /// Neon chip/badge
  static Widget neonBadge({
    required String text,
    Color color = FuryColors.neonPink,
    double fontSize = 12,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
  /// Neon switch/toggle
  static Widget neonSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
    Color activeColor = FuryColors.neonPink,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          color: value ? activeColor.withValues(alpha: 0.3) : FuryColors.glassDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: value ? activeColor : FuryColors.glassLight,
            width: 2,
          ),
          boxShadow: value
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.4),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: value ? activeColor : FuryColors.textMuted,
              shape: BoxShape.circle,
              boxShadow: value
                  ? [
                      BoxShadow(
                        color: activeColor.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
  
  /// Neon loading indicator
  static Widget neonLoader({
    double size = 40,
    Color color = FuryColors.neonPink,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 3,
      ),
    );
  }
  
  /// Neon divider
  static Widget neonDivider({
    Color color = FuryColors.neonPink,
    double thickness = 1,
    double glowRadius = 5,
  }) {
    return Container(
      height: thickness,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            color,
            Colors.transparent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: glowRadius,
          ),
        ],
      ),
    );
  }
  
  /// Avatar with neon ring
  static Widget neonAvatar({
    String? imageUrl,
    String? fallbackText,
    double size = 48,
    bool showRing = true,
    Color ringColor = FuryColors.neonPink,
  }) {
    return Container(
      width: size + 6,
      height: size + 6,
      decoration: showRing
          ? BoxDecoration(
              shape: BoxShape.circle,
              gradient: FuryColors.flameGradient,
              boxShadow: [
                BoxShadow(
                  color: ringColor.withValues(alpha: 0.4),
                  blurRadius: 10,
                ),
              ],
            )
          : null,
      padding: showRing ? const EdgeInsets.all(3) : null,
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: FuryColors.darkSurface,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
        child: imageUrl == null && fallbackText != null
            ? Text(
                fallbackText[0].toUpperCase(),
                style: TextStyle(
                  color: FuryColors.textPrimary,
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
    );
  }
}

/// Extension for easy gradient text
extension GradientText on Text {
  Widget withGradient(Gradient gradient) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: this,
    );
  }
}
