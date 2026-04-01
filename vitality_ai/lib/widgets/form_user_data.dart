import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';

class FormUserData extends StatefulWidget {
  final VoidCallback? onCalculate;

  const FormUserData({super.key, this.onCalculate});

  @override
  State<FormUserData> createState() => _FormUserDataState();
}

class _FormUserDataState extends State<FormUserData> {
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late String _gender;
  late String _activityLevel;
  late String _dietType;

  @override
  void initState() {
    super.initState();
    final provider = context.read<UserProvider>();
    _ageController = TextEditingController(text: provider.userData.age.toString());
    _weightController = TextEditingController(text: provider.userData.weight.toString());
    _heightController = TextEditingController(text: provider.userData.height.toString());
    _gender = provider.userData.gender;
    _activityLevel = provider.userData.activityLevel;
    _dietType = provider.userData.dietType;
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final provider = context.read<UserProvider>();
    provider.updateUserData({
      'age': int.tryParse(_ageController.text) ?? 25,
      'gender': _gender,
      'weight': double.tryParse(_weightController.text) ?? 70,
      'height': double.tryParse(_heightController.text) ?? 170,
      'activityLevel': _activityLevel,
      'dietType': _dietType,
    });
    widget.onCalculate?.call();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final isDark = provider.isDark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E293B).withValues(alpha: 0.4),
                  const Color(0xFF0F172A).withValues(alpha: 0.4),
                ]
              : [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.grey.shade50.withValues(alpha: 0.9),
                ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.analytics_rounded, color: AppTheme.primaryBlue, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.t('updateData'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    provider.t('realTimeAnalysis'),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF94A3B8),
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFieldRow(
            provider,
            [
              _FieldData(
                label: provider.t('age'),
                icon: Icons.calendar_today_rounded,
                child: _buildTextField(_ageController, '25', isDark),
              ),
              _FieldData(
                label: provider.t('gender'),
                icon: Icons.person_rounded,
                child: _buildDropdown(
                  value: _gender,
                  items: [
                    DropdownMenuItem(value: 'male', child: Text(provider.t('male'))),
                    DropdownMenuItem(value: 'female', child: Text(provider.t('female'))),
                  ],
                  onChanged: (v) => setState(() => _gender = v!),
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFieldRow(
            provider,
            [
              _FieldData(
                label: provider.t('height'),
                icon: Icons.height_rounded,
                child: _buildTextField(_heightController, '170', isDark),
              ),
              _FieldData(
                label: provider.t('weight'),
                icon: Icons.monitor_weight_rounded,
                child: _buildTextField(_weightController, '70', isDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFullField(
            provider,
            provider.t('activityLevel'),
            Icons.directions_run_rounded,
            _buildDropdown(
              value: _activityLevel,
              items: const [
                DropdownMenuItem(value: 'sedentary', child: Text('Sedentary')),
                DropdownMenuItem(value: 'light', child: Text('Lightly Active')),
                DropdownMenuItem(value: 'moderate', child: Text('Moderately Active')),
                DropdownMenuItem(value: 'active', child: Text('Very Active')),
              ],
              onChanged: (v) => setState(() => _activityLevel = v!),
              isDark: isDark,
            ),
          ),
          const SizedBox(height: 16),
          _buildFullField(
            provider,
            provider.t('dietType'),
            Icons.restaurant_rounded,
            _buildDropdown(
              value: _dietType,
              items: const [
                DropdownMenuItem(value: 'default', child: Text('Balanced')),
                DropdownMenuItem(value: 'keto', child: Text('Keto Diet')),
                DropdownMenuItem(value: 'vegan', child: Text('Vegan Diet')),
              ],
              onChanged: (v) => setState(() => _dietType = v!),
              isDark: isDark,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                elevation: 8,
                shadowColor: AppTheme.primaryBlue.withValues(alpha: 0.4),
              ),
              child: Text(
                provider.t('calculate'),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldRow(UserProvider provider, List<_FieldData> fields) {
    return Row(
      children: fields.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: entry.key > 0 ? 8 : 0,
              right: entry.key < fields.length - 1 ? 8 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel(entry.value.label, entry.value.icon, provider.isDark),
                const SizedBox(height: 8),
                entry.value.child,
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFullField(UserProvider provider, String label, IconData icon, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, icon, provider.isDark),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildLabel(String label, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, bool isDark) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white : const Color(0xFF0F172A),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFF94A3B8) : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade300,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
      ),
    );
  }
}

class _FieldData {
  final String label;
  final IconData icon;
  final Widget child;

  _FieldData({required this.label, required this.icon, required this.child});
}
