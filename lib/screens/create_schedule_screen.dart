import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/logic/schedules_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key});

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final FMultiSelectGroupController<String> _daysController =
      FMultiSelectGroupController();
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text("schedules_screen.create.title").tr(),
        prefixActions: [
          FHeaderAction.back(
            onPress: () => context.pop(),
          ),
        ],
      ),
      contentPad: false,
      content: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FTextField(
                label: const Text("schedules_screen.form.tag").tr(),
                description:
                    const Text("schedules_screen.form.tag_example").tr(),
                controller: _labelController,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "schedules_screen.form.tag_required".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: FTextField(
                    label: const Text("schedules_screen.form.time").tr(),
                    controller: TextEditingController(
                      text: selectedTime.format(context),
                    ),
                    maxLines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "schedules_screen.form.time_required".tr();
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const FDivider(),
              FSelectTileGroup(
                controller: _daysController,
                label: const Text("schedules_screen.form.days").tr(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "schedules_screen.form.days_required".tr();
                  }
                  return null;
                },
                children: [
                  FSelectTile(
                    title: const Text("schedules_screen.days.monday").tr(),
                    value: "monday",
                  ),
                  FSelectTile(
                    title: const Text("schedules_screen.days.tuesday").tr(),
                    value: "tuesday",
                  ),
                  FSelectTile(
                    title: const Text("schedules_screen.days.wednesday").tr(),
                    value: "wednesday",
                  ),
                  FSelectTile(
                    title: const Text("schedules_screen.days.thursday").tr(),
                    value: "thursday",
                  ),
                  FSelectTile(
                    title: const Text("schedules_screen.days.friday").tr(),
                    value: "friday",
                  ),
                  FSelectTile(
                    title: const Text("schedules_screen.days.saturday").tr(),
                    value: "saturday",
                  ),
                  FSelectTile(
                    title: const Text("schedules_screen.days.sunday").tr(),
                    value: "sunday",
                  ),
                ],
              ),
              const FDivider(),
              FButton(
                onPress: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  String scheduleTime = DateFormat("HH:mm:ss").format(
                    DateTime(0, 1, 1, selectedTime.hour, selectedTime.minute),
                  );
                  Schedule schedule = Schedule(
                    id: 0,
                    label: _labelController.text,
                    time: scheduleTime,
                    days: _daysController.values.toList(),
                  );
                  context.read<SchedulesBloc>().add(AddSchedule(schedule));
                  context.pop();
                },
                style: FButtonStyle.primary,
                label: const Text("schedules_screen.create.title").tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
