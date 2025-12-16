import 'package:flutter/material.dart';

/// Animation constants and helper functions
abstract class AppAnimations {
  // Durations
  static const Duration fastest = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slowest = Duration(milliseconds: 800);
  
  // Curves
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve sharpCurve = Curves.easeOutExpo;
  
  // Message Animations
  static const Duration messageAppear = Duration(milliseconds: 250);
  static const Duration messageDisappear = Duration(milliseconds: 200);
  static const Curve messageCurve = Curves.easeOutBack;
  
  // Typing Indicator
  static const Duration typingDotDelay = Duration(milliseconds: 160);
  static const Duration typingDotDuration = Duration(milliseconds: 600);
  
  // Page Transitions
  static const Duration pageTransition = Duration(milliseconds: 350);
  
  // Micro-interactions
  static const Duration tapFeedback = Duration(milliseconds: 50);
  static const Duration longPressFeedback = Duration(milliseconds: 500);
  static const Duration doubleTapWindow = Duration(milliseconds: 300);
  
  // Chat Bubble Scale on Send
  static Widget messageSendAnimation(Widget child, Animation<double> animation) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
  
  // Swipe to Reply Animation
  static const double swipeThreshold = 60.0;
  static const Duration swipeReplyDuration = Duration(milliseconds: 200);
  
  // Voice Message Recording Animation
  static const Duration voiceWaveformDuration = Duration(milliseconds: 100);
  
  // Story Progress Animation
  static const Duration storySegmentDuration = Duration(seconds: 5);
  
  // Fade in animation
  static Widget fadeIn(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
  
  // Slide in from bottom
  static Widget slideInFromBottom(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: defaultCurve,
      )),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
