import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeColorProvider>();

    return Container(
      color: themeProvider.currentThemeColor.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            "Settings",
            style: AppTextStyles.heading.copyWith(
              color: themeProvider.currentThemeColor.color,
            ),
          ),

          const SizedBox(height: 50),

          Text(
            "Theme",
            style: AppTextStyles.label.copyWith(color: AppColors.textLight),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ThemeColor.values
                .map(
                  (theme) => ThemeColorButton(
                    themeColor: theme,
                    isSelected: theme == themeProvider.currentThemeColor,
                    onTap: (selectedTheme) {
                      // Update both the provider and global variable
                      context.read<ThemeColorProvider>().setThemeColor(
                        selectedTheme,
                      );
                      // Update global variable for backward compatibility
                      currentThemeColor = selectedTheme;
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
