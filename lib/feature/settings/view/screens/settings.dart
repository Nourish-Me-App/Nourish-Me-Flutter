import '../../../../core/imports/app_routes_imports.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings Screen'),
        ),
        body: const Center(
          child: Text('Settings Screen'),
        ));
  }
}
