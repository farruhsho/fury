
enum VideoQuality {
  auto,
  low,
  medium,
  high,
}

class AudioSettings {
  final bool noiseSuppression;
  final bool echoCancellation;
  final bool autoGainControl;

  const AudioSettings({
    this.noiseSuppression = true,
    this.echoCancellation = true,
    this.autoGainControl = true,
  });
  
  AudioSettings copyWith({
    bool? noiseSuppression,
    bool? echoCancellation,
    bool? autoGainControl,
  }) {
    return AudioSettings(
      noiseSuppression: noiseSuppression ?? this.noiseSuppression,
      echoCancellation: echoCancellation ?? this.echoCancellation,
      autoGainControl: autoGainControl ?? this.autoGainControl,
    );
  }
}
