import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/slider_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'add_screen_state.dart';

class AddScreenCubit extends Cubit<AddScreenState> {
  int index = 0;
  late List<String> sliders;
  late ServiceApi api;

  AddScreenCubit() : super(OnPositionChangedState(pos: 0)) {
    api = ServiceApi();
    sliders = [];
    getSlider();
  }

  void updatePos({required int pos}) {
    index = pos;
    emit(OnPositionChangedState(pos: pos));
  }

  getSlider() async {
    try {
      SliderModel response = await api.getSliders();
      if (response.status.code == 200) {
        sliders = response.images;

        emit(OnSliderDataSuccess(sliders));
      } else {
        OnError("error data");
      }
    } catch (error) {
      OnError(error.toString());
    }
  }
}
