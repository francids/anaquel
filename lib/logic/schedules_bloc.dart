import 'package:anaquel/data/models/schedule.dart';
import 'package:anaquel/data/services/schedules_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SchedulesEvent {}

class GetSchedules extends SchedulesEvent {}

class AddSchedule extends SchedulesEvent {
  final Schedule schedule;

  AddSchedule(this.schedule);
}

class UpdateSchedule extends SchedulesEvent {
  final Schedule schedule;

  UpdateSchedule(this.schedule);
}

class DeleteSchedule extends SchedulesEvent {
  final int schedule;

  DeleteSchedule(this.schedule);
}

abstract class SchedulesState {}

class SchedulesInitial extends SchedulesState {}

class SchedulesLoading extends SchedulesState {}

class SchedulesLoaded extends SchedulesState {
  final List<Schedule> schedules;

  SchedulesLoaded(this.schedules);
}

class SchedulesError extends SchedulesState {
  final String message;

  SchedulesError(this.message);
}

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  final SchedulesService schedulesService;

  SchedulesBloc(this.schedulesService) : super(SchedulesInitial()) {
    on<GetSchedules>((event, emit) async {
      emit(SchedulesLoading());
      try {
        final schedules = await schedulesService.getSchedules();
        emit(SchedulesLoaded(schedules));
      } catch (e) {
        emit(SchedulesError(e.toString()));
      }
    });

    on<AddSchedule>((event, emit) async {
      emit(SchedulesLoading());
      try {
        await schedulesService.addSchedule(event.schedule);
        final schedules = await schedulesService.getSchedules();
        emit(SchedulesLoaded(schedules));
      } catch (e) {
        emit(SchedulesError(e.toString()));
      }
    });

    on<UpdateSchedule>((event, emit) async {
      emit(SchedulesLoading());
      try {
        await schedulesService.updateSchedule(event.schedule);
        final schedules = await schedulesService.getSchedules();
        emit(SchedulesLoaded(schedules));
      } catch (e) {
        emit(SchedulesError(e.toString()));
      }
    });

    on<DeleteSchedule>((event, emit) async {
      emit(SchedulesLoading());
      try {
        await schedulesService.deleteSchedule(event.schedule);
        final schedules = await schedulesService.getSchedules();
        emit(SchedulesLoaded(schedules));
      } catch (e) {
        emit(SchedulesError(e.toString()));
      }
    });
  }
}
