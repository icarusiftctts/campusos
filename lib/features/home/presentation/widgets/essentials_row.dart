import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/glass_container.dart';

class EssentialsRow extends StatelessWidget {
  const EssentialsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'label': 'Campus Map', 'icon': Icons.map_rounded},
      {'label': 'Contacts', 'icon': Icons.call_rounded},
      {'label': 'Curriculum', 'icon': Icons.menu_book_rounded},
      {'label': 'Links', 'icon': Icons.link_rounded},
      {'label': 'Gymkhana', 'icon': Icons.groups_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            'Campus Essentials',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: GlassContainer(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(items[index]['icon'],
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          items[index]['label'],
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
