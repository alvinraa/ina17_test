part of 'take_photo_bloc.dart';

@immutable
sealed class TakePhotoEvent {}

class TakePhotoRequest extends TakePhotoEvent {
  final String value;
  TakePhotoRequest({required this.value});
}
