import 'package:bloc/bloc.dart';
import 'package:ina17_test/core/common/logger.dart';
import 'package:meta/meta.dart';

part 'take_photo_event.dart';
part 'take_photo_state.dart';

class TakePhotoBloc extends Bloc<TakePhotoEvent, TakePhotoState> {
  TakePhotoBloc() : super(TakePhotoInitial()) {
    on<TakePhotoRequest>((event, emit) async {
      await getTakePhoto(event, emit);
    });
  }

  int result = 0;

  Future<void> getTakePhoto(
    TakePhotoRequest event,
    Emitter<TakePhotoState> emit,
  ) async {
    try {
      emit(TakePhotoLoading());
      result = calculate(event.value);
      emit(TakePhotoLoaded());
    } catch (e) {
      Logger.print(e.toString());
      var errorMessage =
          'error when process image to text, please try again with another image';
      emit(TakePhotoError(errorMessage: errorMessage));
    }
  }

  // for now only support single calculation
  // example : 1+1, 2-2, 33, 4:2
  int calculate(String s) {
    // Split string based on the operators
    List<String> numbers = s.split(RegExp(r'[\+\-\*\/\x\:]'));

    // Get the operator
    String operator = s.replaceAll(RegExp(r'[0-9]'), '');

    // Convert string numbers to integers
    int num1 = int.parse(numbers[0]);
    int num2 = int.parse(numbers[1]);

    // Perform the operation based on the operator
    switch (operator) {
      case '+':
        return num1 + num2; // penambahan
      case '-':
        return num1 - num2; // pengurangan
      case '' 'x':
        return num1 * num2; // perkalian
      case '/' ':':
        return num1 ~/ num2; // pembagian Integer
      default:
        throw Exception('Invalid operator');
    }
  }
}
