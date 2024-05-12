import '../../../../core/imports/app_routes_imports.dart';

class WorkOutScreen extends StatelessWidget {
  const WorkOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WorkOut Screen'),
        ),
        body: const Center(
          child: Text('WorkOut Screen'),
        ));
  }
}
