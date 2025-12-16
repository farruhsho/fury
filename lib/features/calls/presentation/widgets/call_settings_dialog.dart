import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/media_settings.dart';
import '../bloc/call_bloc.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_colors.dart';

class CallSettingsDialog extends StatelessWidget {
  const CallSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        final currentQuality = state.videoQuality;
        final audioSettings = state.audioSettings;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Настройки Звонка',
                style: AppTypography.h3.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 24),
              
              Text(
                'Качество Видео',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondaryLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _buildQualitySelector(context, currentQuality),
              
              const SizedBox(height: 24),
               Text(
                'Аудио Настройки',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondaryLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _buildSwitch(
                'Шумоподавление (Noise Suppression)',
                audioSettings.noiseSuppression,
                (val) => context.read<CallBloc>().add(
                  CallEvent.updateAudioSettings(
                    audioSettings.copyWith(noiseSuppression: val),
                  ),
                ),
              ),
              _buildSwitch(
                'Эхоподавление (Echo Cancellation)',
                audioSettings.echoCancellation,
                (val) => context.read<CallBloc>().add(
                  CallEvent.updateAudioSettings(
                    audioSettings.copyWith(echoCancellation: val),
                  ),
                ),
              ),
               _buildSwitch(
                'Авто-громкость (Gain Control)',
                audioSettings.autoGainControl,
                (val) => context.read<CallBloc>().add(
                  CallEvent.updateAudioSettings(
                    audioSettings.copyWith(autoGainControl: val),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQualitySelector(BuildContext context, VideoQuality current) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildQualityOption(context, 'Авто', VideoQuality.auto, current),
          _buildQualityOption(context, 'Низкое', VideoQuality.low, current),
          _buildQualityOption(context, 'Среднее', VideoQuality.medium, current),
          _buildQualityOption(context, 'Высокое', VideoQuality.high, current),
        ],
      ),
    );
  }

  Widget _buildQualityOption(
    BuildContext context, 
    String label, 
    VideoQuality value, 
    VideoQuality current,
  ) {
    final isSelected = value == current;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<CallBloc>().add(CallEvent.setVideoQuality(value)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
