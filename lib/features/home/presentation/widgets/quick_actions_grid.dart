import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [
      {
        'title': 'Lecture Recorder',
        'sub': 'Record and summarize',
        'icon': Icons.mic_rounded,
        'color': AppColors.secondary,
        'path': '/recorder',
      },
      {
        'title': 'Assignment OCR',
        'sub': 'Scan assignments',
        'icon': Icons.document_scanner_rounded,
        'color': AppColors.primary,
        'path': '/ocr',
      },
      {
        'title': 'Flashcards',
        'sub': 'Review concepts',
        'icon': Icons.psychology_rounded,
        'color': AppColors.success,
        'path': '/flashcards',
      },
      {
        'title': 'Expense Splitter',
        'sub': 'Track shared costs',
        'icon': Icons.account_balance_wallet_rounded,
        'color': AppColors.warning,
        'path': '/expenses',
      },
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.35,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = actions[index];
          return GestureDetector(
            onTap: () => context.push(item['path']),
            child: GlassContainer(
              child: Stack(
                children: [
                  // Subtle Glow Overlay
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (item['color'] as Color).withOpacity(0.1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(item['icon'],
                              color: item['color'], size: 24),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['sub'],
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: actions.length,
      ),
    );
  }
}
