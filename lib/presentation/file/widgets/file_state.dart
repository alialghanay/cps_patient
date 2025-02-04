import 'package:flutter/material.dart';
import 'package:cps_patient/models/file_model.dart'; // Import the `FileStatus` enum

class FileStateWidget extends StatelessWidget {
  final FileStatus currentState;

  const FileStateWidget({Key? key, required this.currentState})
      : super(key: key);

  /// Helper to determine the step color:
  /// - **Completed & Active Steps** → Blue
  /// - **Upcoming Steps** → Grey
  Color _getStateColor(FileStatus stepState) {
    final stepOrder = _getStepOrder(stepState);
    final currentOrder = _getStepOrder(currentState);

    return stepOrder <= currentOrder
        ? Colors.blue.shade700 // ✅ Completed & Active steps are blue
        : Colors.grey.shade400; // 🚧 Future steps are grey
  }

  /// Helper to determine the order of each status
  int _getStepOrder(FileStatus status) {
    switch (status) {
      case FileStatus.pending:
        return 0;
      case FileStatus.assigned:
        return 1;
      case FileStatus.waiting_approval:
        return 2;
      case FileStatus.ready_download:
        return 3;
      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> steps = [
      {
        'step': 'تم استلام العينة',
        'state': FileStatus.pending
      }, // "Sample Received"
      {'step': 'قيد التشخيص', 'state': FileStatus.assigned}, // "In Diagnosis"
      {
        'step': 'في انتظار الموافقة',
        'state': FileStatus.waiting_approval
      }, // "Waiting for Approval"
      {
        'step': 'جاهز للتحميل',
        'state': FileStatus.ready_download
      }, // "Ready for Download"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مراحل الجاهزية:', // Arabic for "Readiness Stages"
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Column(
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;
            final stepState = step['state'] as FileStatus;
            final nextStepState =
                !isLast ? steps[index + 1]['state'] as FileStatus : null;

            return Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: _getStateColor(stepState),
                          radius: 18,
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        if (!isLast) // ✅ Add a vertical line between steps
                          Container(
                            width: 2,
                            height: 30,
                            color: _getStateColor(nextStepState!),
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        step['step'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
