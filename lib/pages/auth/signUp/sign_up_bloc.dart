import 'package:bloc/bloc.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

//save data to sending it to firebase
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    ImagePicker imagePicker = ImagePicker();

    on<RetrieveLostDataEvent>((event, emit) async {
      final LostDataResponse response = await imagePicker.retrieveLostData();
      if (response.file != null) {
        //sending photo
        emit(PictureSelectedState(
            imageData: await response.file!.readAsBytes()));
      }
    });

    //image from gallary
    on<ChooseImageFromGalleryEvent>((event, emit) async {
      XFile? xImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (xImage != null) {
        emit(PictureSelectedState(imageData: await xImage.readAsBytes()));
      }
    });

//image from camera
    on<CaptureImageByCameraEvent>((event, emit) async {
      XFile? xImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (xImage != null) {
        emit(PictureSelectedState(imageData: await xImage.readAsBytes()));
      }
    });

//if information is required you must fill it
    on<ValidateFieldsEvent>((event, emit) async {
      if (event.key.currentState?.validate() ?? false) {
        if (event.acceptEula) {
          event.key.currentState!.save();
          emit(ValidFields());
        } else {
          emit(SignUpFailureState(
              errorMessage: 'Please accept our terms of use.'));
        }
      } else {
        emit(SignUpFailureState(errorMessage: 'Please fill required fields.'));
      }
    });
//information accept
    on<ToggleEulaCheckboxEvent>(
        (event, emit) => emit(EulaToggleState(event.eulaAccepted)));
  }
}
