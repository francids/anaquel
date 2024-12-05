import 'package:anaquel/logic/schedules_bloc.dart';
import 'package:anaquel/screens/create_schedule_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:anaquel/widgets/schedule_card.dart';

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
            label: const Text("schedules_screen.create_schedule").tr(),
          ),
          const SizedBox(height: 8),
          BlocBuilder<SchedulesBloc, SchedulesState>(
            builder: (context, state) {
              if (state is SchedulesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SchedulesLoaded) {
                if (state.schedules.isEmpty) {
                  return FAlert(
                    icon: FAssets.icons.badgeInfo(),
                    title: const Text("schedules_screen.no_schedules").tr(),
                    style: FAlertStyle.primary,
                  );
                }
                return Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ScheduleCard(
                          schedule: state.schedules[index],
                        );
                      },
                      itemCount: state.schedules.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: const Text("schedules_screen.bottom").tr(),
                    ),
                  ],
                );
              } else if (state is SchedulesError) {
                return FAlert(
                  icon: FAssets.icons.badgeX(),
                  title: const Text("Error"),
                  subtitle: Text(state.message),
                  style: FAlertStyle.destructive,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
