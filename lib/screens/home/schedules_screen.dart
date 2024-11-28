import 'package:anaquel/screens/create_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:anaquel/widgets/schedule_card.dart';

List<String> _times = [
  '08:00 AM',
  '05:00 PM',
];

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          FButton(
            onPress: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const CreateScheduleScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            style: FButtonStyle.primary,
            label: const Text("Crear hora de lectura"),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ScheduleCard(time: _times[index]);
            },
            itemCount: _times.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
          ),
          const SizedBox(
            width: double.infinity,
            child: Text("Selecciona una hora para editar o eliminar"),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
