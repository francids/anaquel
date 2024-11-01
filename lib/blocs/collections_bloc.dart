import 'package:anaquel/data/models/collection.dart';
import 'package:anaquel/data/services/collections_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CollectionsEvent {}

class GetCollections extends CollectionsEvent {}

class CreateCollection extends CollectionsEvent {
  final String name;
  final String color;

  CreateCollection(this.name, this.color);
}

abstract class CollectionsState {}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoading extends CollectionsState {}

class CollectionsLoaded extends CollectionsState {
  final List<Collection> collections;

  CollectionsLoaded(this.collections);
}

class CollectionsError extends CollectionsState {
  final String message;

  CollectionsError(this.message);
}

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final CollectionsService collectionsService;

  CollectionsBloc(this.collectionsService) : super(CollectionsInitial()) {
    on<GetCollections>((event, emit) async {
      emit(CollectionsLoading());
      try {
        final collections = await collectionsService.getCollections();
        emit(CollectionsLoaded(collections));
      } catch (e) {
        emit(CollectionsError(e.toString()));
      }
    });

    on<CreateCollection>((event, emit) async {
      emit(CollectionsLoading());
      try {
        await collectionsService.createCollection(event.name, event.color);
        final collections = await collectionsService.getCollections();
        emit(CollectionsLoaded(collections));
      } catch (e) {
        emit(CollectionsError(e.toString()));
      }
    });
  }
}
