import 'package:flutter/material.dart';

class UserDetailsTile extends StatelessWidget {
  final String title;
  final String value;

  const UserDetailsTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 80, maxWidth: 120),
            child: Text(
              '$title:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isSmallScreen ? 13 : 15,
                color: Colors.black87,
              ),
            ),
          ),

          // Spacer
          const SizedBox(width: 8),

          // Value
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isSmallScreen ? 13 : 15,
                color: Colors.grey[800],
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
