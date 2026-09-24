import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ResultScreen extends StatelessWidget {
  final int predictedDemand;
  final String summary; 

  const ResultScreen({
    super.key,
    required this.predictedDemand,
    required this.summary,
  });

  // Simple helper to color-code the result based on how high it is.
  Color get _demandColor {
    if (predictedDemand >= 300) return AppColors.success;
    if (predictedDemand >= 100) return AppColors.warning;
    return AppColors.danger;
  }

  String get _demandLabel {
    if (predictedDemand >= 300) return 'High Demand';
    if (predictedDemand >= 100) return 'Moderate Demand';
    return 'Low Demand';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Prediction Result',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [AppColors.cardShadow],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: _demandColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.pedal_bike_rounded,
                      size: 48,
                      color: _demandColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '$predictedDemand',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'bikes expected',
                    style: TextStyle(fontSize: 16, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: _demandColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _demandLabel,
                      style: TextStyle(
                        color: _demandColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Conditions summary card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [AppColors.cardShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Based on',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summary,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textDark,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Try Another Prediction'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}