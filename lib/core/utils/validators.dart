/// Validators for user input
class Validators {
  /// Validate phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length < 9) {
      return 'Phone number must be at least 9 digits';
    }

    if (digits.length > 15) {
      return 'Phone number is too long';
    }

    return null;
  }
  
  /// Validate OTP code
  static String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Verification code is required';
    }
    
    if (value.length != 6) {
      return 'Verification code must be 6 digits';
    }
    
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Verification code must contain only digits';
    }
    
    return null;
  }
  
  /// Validate display name
  static String? validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.length > 50) {
      return 'Name is too long';
    }
    
    return null;
  }
  
  /// Validate username
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Username is optional
    }
    
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    
    if (value.length > 30) {
      return 'Username is too long';
    }
    
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
  }
  
  /// Validate bio
  static String? validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Bio is optional
    }
    
    if (value.length > 140) {
      return 'Bio is too long (max 140 characters)';
    }
    
    return null;
  }
  
  /// Validate group name
  static String? validateGroupName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Group name is required';
    }
    
    if (value.length < 2) {
      return 'Group name must be at least 2 characters';
    }
    
    if (value.length > 256) {
      return 'Group name is too long';
    }
    
    return null;
  }
  
  /// Validate group description
  static String? validateGroupDescription(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Description is optional
    }
    
    if (value.length > 512) {
      return 'Description is too long (max 512 characters)';
    }
    
    return null;
  }
  
  /// Validate message text
  static String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Message cannot be empty';
    }
    
    if (value.length > 4096) {
      return 'Message is too long (max 4096 characters)';
    }
    
    return null;
  }
  
  /// Validate email (optional)
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Email is optional
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    
    return null;
  }
}
