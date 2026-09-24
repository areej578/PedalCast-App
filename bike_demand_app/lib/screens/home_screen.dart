import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/api_service.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, int> _seasons = {
    'Winter': 1,
    'Spring': 2,
    'Summer': 3,
    'Fall': 4,
  };
  final Map<String, int> _weatherOptions = {
    'Clear': 1,
    'Mist / Cloudy': 2,
    'Light Rain / Snow': 3,
    'Heavy Rain / Snow': 4,
  };
  final Map<String, int> _weekdays = {
    'Sunday': 0,
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
  };
  final Map<String, int> _years = {'2011': 0, '2012': 1};

  String _selectedSeason = 'Summer';
  String _selectedWeather = 'Clear';
  String _selectedWeekday = 'Monday';
  String _selectedYear = '2012';

  int _hour = 8;
  int _month = 7;
  bool _isHoliday = false;
  bool _isWorkingDay = true;

  double _temp = 0.6;
  double _atemp = 0.55;
  double _hum = 0.5;
  double _windspeed = 0.2;

  bool _loading = false;
  String? _errorMessage;

  Future<void> _predict() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final prediction = await ApiService.getPrediction(
        temp: _temp,
        atemp: _atemp,
        hum: _hum,
        windspeed: _windspeed,
        hr: _hour,
        mnth: _month,
        season: _seasons[_selectedSeason]!,
        weathersit: _weatherOptions[_selectedWeather]!,
        weekday: _weekdays[_selectedWeekday]!,
        holiday: _isHoliday ? 1 : 0,
        workingday: _isWorkingDay ? 1 : 0,
        yr: _years[_selectedYear]!,
      );

      final summary =
          '$_selectedWeather weather, ${_hour.toString().padLeft(2, '0')}:00, '
          '$_selectedSeason, ${_isWorkingDay ? 'Working day' : 'Non-working day'}';

      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            predictedDemand: prediction,
            summary: summary,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not get a prediction. Check your backend URL '
            'and make sure the server is running.\n\n$e';
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'PedalCast',
          style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter conditions',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              const Text(
                'Fill in the weather and time details to predict rental demand.',
                style: TextStyle(color: AppColors.textGrey),
              ),
              const SizedBox(height: 24),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Season'),
                    _dropdown(
                      value: _selectedSeason,
                      items: _seasons.keys.toList(),
                      onChanged: (val) => setState(() => _selectedSeason = val!),
                    ),
                    const SizedBox(height: 16),
                    _sectionLabel('Weather Condition'),
                    _dropdown(
                      value: _selectedWeather,
                      items: _weatherOptions.keys.toList(),
                      onChanged: (val) => setState(() => _selectedWeather = val!),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionLabel('Day of Week'),
                              _dropdown(
                                value: _selectedWeekday,
                                items: _weekdays.keys.toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedWeekday = val!),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _sectionLabel('Year'),
                              _dropdown(
                                value: _selectedYear,
                                items: _years.keys.toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedYear = val!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Hour of Day: ${_hour.toString().padLeft(2, '0')}:00'),
                    Slider(
                      value: _hour.toDouble(),
                      min: 0,
                      max: 23,
                      divisions: 23,
                      activeColor: AppColors.primary,
                      label: _hour.toString(),
                      onChanged: (val) => setState(() => _hour = val.round()),
                    ),
                    _sectionLabel('Month: $_month'),
                    Slider(
                      value: _month.toDouble(),
                      min: 1,
                      max: 12,
                      divisions: 11,
                      activeColor: AppColors.primary,
                      label: _month.toString(),
                      onChanged: (val) => setState(() => _month = val.round()),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Temperature (normalized): ${_temp.toStringAsFixed(2)}'),
                    Slider(
                      value: _temp,
                      min: 0,
                      max: 1,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _temp = val),
                    ),
                    _sectionLabel('Feels-like Temp: ${_atemp.toStringAsFixed(2)}'),
                    Slider(
                      value: _atemp,
                      min: 0,
                      max: 1,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _atemp = val),
                    ),
                    _sectionLabel('Humidity: ${_hum.toStringAsFixed(2)}'),
                    Slider(
                      value: _hum,
                      min: 0,
                      max: 1,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _hum = val),
                    ),
                    _sectionLabel('Windspeed: ${_windspeed.toStringAsFixed(2)}'),
                    Slider(
                      value: _windspeed,
                      min: 0,
                      max: 1,
                      activeColor: AppColors.primary,
                      onChanged: (val) => setState(() => _windspeed = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              _card(
                child: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColors.primary,
                      title: const Text('Holiday'),
                      value: _isHoliday,
                      onChanged: (val) => setState(() => _isHoliday = val),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: AppColors.primary,
                      title: const Text('Working Day'),
                      value: _isWorkingDay,
                      onChanged: (val) => setState(() => _isWorkingDay = val),
                    ),
                  ],
                ),
              ),

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: AppColors.danger, fontSize: 13),
                  ),
                ),
              ],

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _predict,
                  child: _loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text('Predict Demand'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppColors.cardShadow],
      ),
      child: child,
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}