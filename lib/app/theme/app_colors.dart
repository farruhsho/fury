import 'package:flutter/material.dart';

/// 🔥 Fury Chat Neon Color Palette
/// Based on the flame icon with pink-purple-cyan neon-glass aesthetic
abstract class FuryColors {
  // ============ PRIMARY NEON COLORS ============
  
  /// Core flame pink - Primary accent
  static const Color neonPink = Color(0xFFFF2D92);
  
  /// Hot magenta - Buttons, highlights
  static const Color hotMagenta = Color(0xFFFF0080);
  
  /// Electric purple - Gradients, glow
  static const Color electricPurple = Color(0xFF9D00FF);
  
  /// Cyber cyan - Secondary accent
  static const Color cyberCyan = Color(0xFF00F5FF);
  
  /// Neon blue - Info states
  static const Color neonBlue = Color(0xFF0066FF);
  
  // ============ BACKGROUND COLORS ============
  
  /// Deep black - Primary background
  static const Color deepBlack = Color(0xFF0A0A0F);
  
  /// Dark surface - Cards, elevated
  static const Color darkSurface = Color(0xFF12121A);
  
  /// Glass dark - Glass panels
  static const Color glassDark = Color(0xFF1A1A25);
  
  /// Glass light - Lighter glass
  static const Color glassLight = Color(0xFF2A2A3A);
  
  // ============ TEXT COLORS ============
  
  /// Pure white - Primary text
  static const Color textPrimary = Color(0xFFFFFFFF);
  
  /// Soft white - Body text
  static const Color textSecondary = Color(0xFFE0E0E8);
  
  /// Muted gray - Tertiary text (improved contrast)
  static const Color textMuted = Color(0xFFA0A0B8);
  
  /// Dim gray - Disabled
  static const Color textDisabled = Color(0xFF555570);
  
  // ============ SEMANTIC COLORS ============
  
  static const Color success = Color(0xFF00FF88);
  static const Color warning = Color(0xFFFFAA00);
  static const Color error = Color(0xFFFF4466);
  static const Color info = Color(0xFF00F5FF);
  
  // ============ CHAT COLORS ============
  
  /// Outgoing bubble gradient start
  static const Color outgoingBubbleStart = Color(0xFF2A1A40);
  
  /// Outgoing bubble gradient end
  static const Color outgoingBubbleEnd = Color(0xFF1A1025);
  
  /// Incoming bubble
  static const Color incomingBubble = Color(0xFF1A1A25);
  
  /// Online indicator
  static const Color online = Color(0xFF00FF88);
  
  /// Typing indicator
  static const Color typing = Color(0xFF00F5FF);
  
  /// Recording indicator
  static const Color recording = Color(0xFFFF2D92);
  
  // ============ READ RECEIPTS ============
  
  static const Color checkSent = Color(0xFF8888A0);
  static const Color checkDelivered = Color(0xFF8888A0);
  static const Color checkRead = Color(0xFF00F5FF);
  
  // ============ GRADIENTS ============
  
  /// Flame gradient - Primary brand gradient
  static const LinearGradient flameGradient = LinearGradient(
    colors: [neonPink, electricPurple, neonBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Neon glow gradient
  static const LinearGradient neonGlowGradient = LinearGradient(
    colors: [hotMagenta, cyberCyan],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  /// Glass surface gradient
  static LinearGradient glassGradient = LinearGradient(
    colors: [
      Colors.white.withValues(alpha: 0.15),
      Colors.white.withValues(alpha: 0.05),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  /// Chat bubble outgoing gradient
  static const LinearGradient outgoingBubbleGradient = LinearGradient(
    colors: [outgoingBubbleStart, outgoingBubbleEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Sunset flame gradient
  static const LinearGradient sunsetFlame = LinearGradient(
    colors: [Color(0xFFFF6B6B), neonPink, electricPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Cool neon gradient
  static const LinearGradient coolNeon = LinearGradient(
    colors: [cyberCyan, neonBlue, electricPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // ============ SHADOWS ============
  
  /// Neon glow shadow for pink elements
  static List<BoxShadow> neonPinkGlow({double intensity = 1.0}) => [
    BoxShadow(
      color: neonPink.withValues(alpha: 0.4 * intensity),
      blurRadius: 20 * intensity,
      spreadRadius: 2 * intensity,
    ),
  ];
  
  /// Neon glow shadow for cyan elements
  static List<BoxShadow> neonCyanGlow({double intensity = 1.0}) => [
    BoxShadow(
      color: cyberCyan.withValues(alpha: 0.4 * intensity),
      blurRadius: 20 * intensity,
      spreadRadius: 2 * intensity,
    ),
  ];
  
  /// Neon glow shadow for purple elements
  static List<BoxShadow> neonPurpleGlow({double intensity = 1.0}) => [
    BoxShadow(
      color: electricPurple.withValues(alpha: 0.4 * intensity),
      blurRadius: 20 * intensity,
      spreadRadius: 2 * intensity,
    ),
  ];
  
  /// Card shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Elevated shadow
  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];
}

/// WhatsApp-style colors for modern dark theme
abstract class WhatsAppColors {
  // === PRIMARY ===
  static const Color primary = Color(0xFF00A884);  // WhatsApp green
  static const Color primaryDark = Color(0xFF008069);
  static const Color primaryLight = Color(0xFF25D366);
  
  // === BACKGROUND ===
  static const Color background = Color(0xFF0B141A);
  static const Color surface = Color(0xFF1F2C33);
  static const Color surfaceLight = Color(0xFF2A3942);
  
  // === TEXT ===
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8696A0);
  static const Color textMuted = Color(0xFF667781);
  
  // === CHAT BUBBLES ===
  static const Color outgoingBubble = Color(0xFF005C4B);  // Dark green
  static const Color incomingBubble = Color(0xFF202C33);  // Dark gray
  
  // === BADGES & INDICATORS ===
  static const Color unreadBadge = Color(0xFF00A884);
  static const Color online = Color(0xFF00A884);
  static const Color checkRead = Color(0xFF53BDEB);
  static const Color checkDelivered = Color(0xFF8696A0);
}

/// Extension for easy access via existing AppColors references
/// REVERTED: Back to original Fury neon pink theme
abstract class AppColors {
  // Original neon pink theme
  static const Color primary = FuryColors.neonPink;
  static const Color primaryLight = FuryColors.hotMagenta;
  static const Color primaryDark = FuryColors.electricPurple;
  static const Color secondary = FuryColors.electricPurple;
  static const Color accent = FuryColors.cyberCyan;
  
  static const Color backgroundLight = FuryColors.glassLight;
  static const Color backgroundDark = FuryColors.deepBlack;
  static const Color surfaceLight = FuryColors.glassDark;
  static const Color surfaceDark = FuryColors.darkSurface;
  
  static const Color outgoingBubbleLight = FuryColors.outgoingBubbleStart;
  static const Color outgoingBubbleDark = FuryColors.outgoingBubbleEnd;
  static const Color incomingBubbleLight = FuryColors.incomingBubble;
  static const Color incomingBubbleDark = FuryColors.incomingBubble;
  
  static const Color textPrimaryLight = FuryColors.textPrimary;
  static const Color textPrimaryDark = FuryColors.textPrimary;
  static const Color textSecondaryLight = FuryColors.textMuted;
  static const Color textSecondaryDark = FuryColors.textMuted;
  
  static const Color online = FuryColors.online;
  static const Color offline = FuryColors.textMuted;
  static const Color typing = FuryColors.typing;
  static const Color recording = FuryColors.recording;
  
  static const Color singleCheck = FuryColors.checkSent;
  static const Color doubleCheck = FuryColors.checkDelivered;
  static const Color doubleCheckRead = FuryColors.checkRead;
  
  static const Color error = FuryColors.error;
  static const Color warning = FuryColors.warning;
  static const Color success = FuryColors.success;
  static const Color info = FuryColors.info;
  
  static const LinearGradient storyGradient = FuryColors.flameGradient;
  static const LinearGradient callGradient = FuryColors.coolNeon;
  static const LinearGradient primaryGradient = FuryColors.flameGradient;
}
