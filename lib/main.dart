import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/feature/screens/home_page.dart';
import 'src/global/constants/apod_theme.dart';

void main() => runApp(const ProviderScope(child: ApodApp()));

class ApodApp extends StatelessWidget {
  const ApodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APOD',
      debugShowCheckedModeBanner: false,
      theme: ApodTheme.light(),
      darkTheme: ApodTheme.dark(),
      home: const HomePage(title: 'Astronomy Picture of the Day'),
    );
  }
}
