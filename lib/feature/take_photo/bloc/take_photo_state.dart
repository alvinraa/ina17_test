part of 'take_photo_bloc.dart';

@immutable
sealed class TakePhotoState {}

final class TakePhotoInitial extends TakePhotoState {}

final class TakePhotoLoading extends TakePhotoState {}

final class TakePhotoLoaded extends TakePhotoState {
  TakePhotoLoaded();
}

final class TakePhotoError extends TakePhotoState {
  final String? errorMessage;
  TakePhotoError({this.errorMessage});
}
