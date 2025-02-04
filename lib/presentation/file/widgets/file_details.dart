import 'package:cps_patient/models/patient.dart';
import 'package:flutter/material.dart';

class FileDetailsWidget extends StatelessWidget {
  final dynamic file;

  const FileDetailsWidget({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling inside the grid
      shrinkWrap: true, // Allow the grid to adjust its size
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 10, // Horizontal spacing between items
        mainAxisSpacing: 10, // Vertical spacing between items
        childAspectRatio: 3, // Adjust the height of the items
      ),
      children: [
        _buildGridItem(
          context,
          'الاسم:',
          file.patient.name, // Arabic for "Name"
          Icons.person, // Generic person icon
        ),
        _buildGridItem(
          context,
          'العمر:',
          _calculateAge(file.patient.birthDate).toString(), // Arabic for "Age"
          Icons.calendar_today, // Calendar icon
        ),
        _buildGridItem(
          context,
          'الجنس:',
          '',
          _getGenderIcon(file.patient.gender), // Gender-based icon
          _getGenderColor(file.patient.gender),
        ),
        _buildGridItem(
          context,
          'الجنسية:',
          file.nationalityName, // Arabic for "Nationality"
          Icons.flag, // Flag icon for nationality
        ),
      ],
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, [
    Color? iconColor,
  ]) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor ?? Colors.black, size: 24), // Icon
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method to calculate age from a birthDate string (YYYY-MM-DD)
  int _calculateAge(String birthDate) {
    try {
      final birthDateParsed = DateTime.parse(birthDate);
      final today = DateTime.now();
      int age = today.year - birthDateParsed.year;

      // Adjust for months and days
      if (today.month < birthDateParsed.month ||
          (today.month == birthDateParsed.month &&
              today.day < birthDateParsed.day)) {
        age--;
      }

      return age;
    } catch (e) {
      // Handle invalid date formats gracefully
      return 0; // Default to 0 if parsing fails
    }
  }

  /// Helper method to get gender icon
  IconData _getGenderIcon(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Icons.male; // Boy icon
      case Gender.female:
        return Icons.female; // Girl icon
      case Gender.other:
      default:
        return Icons.help_outline; // Unknown icon
    }
  }

  /// Helper method to get gender icon color
  Color _getGenderColor(Gender gender) {
    switch (gender) {
      case Gender.male:
        return Colors.blue; // Blue for boys
      case Gender.female:
        return Colors.pink; // Pink for girls
      case Gender.other:
      default:
        return Colors.grey; // Grey for unspecified
    }
  }
}
