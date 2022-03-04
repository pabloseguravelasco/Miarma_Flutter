
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/register_dto.dart';
import 'package:flutter_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_miarmapp/repository/register_repository/register_repository.dart';
import 'package:image_picker/image_picker.dart';



part 'image_pick_bloc_event.dart';
part 'image_pick_bloc_state.dart';

class ImagePickBlocBloc extends Bloc<ImagePickBlocEvent, ImagePickBlocState> {
  final RegisterRepository registerRepository;
  ImagePickBlocBloc(this.registerRepository) : super(ImagePickBlocInitial()) {
    on<SelectImageEvent>(_onSelectImage);
   
  }

  void _onSelectImage(
      SelectImageEvent event, Emitter<ImagePickBlocState> emit) async {
    final ImagePicker _picker = ImagePicker();

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: event.source,
      );
      if (pickedFile != null) {
        emit(ImageSelectedSuccessState(pickedFile));
      } else {
        emit(const ImageSelectedErrorState('Error in image selection'));
      }
    } catch (e) {
      emit(const ImageSelectedErrorState('Error in image selection'));
    }
  }



}