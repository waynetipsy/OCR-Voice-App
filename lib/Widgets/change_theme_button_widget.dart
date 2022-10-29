import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/theme.provider.dart';

class ChangeThemeButtonWidgets extends StatelessWidget {
  const ChangeThemeButtonWidgets({super.key});


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      activeColor: Colors.white,
      inactiveThumbColor: Colors.black,
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
           provider.toggleTheme(value);
        },
      );
  }
}