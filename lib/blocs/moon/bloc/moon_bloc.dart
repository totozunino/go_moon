import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_moon/blocs/moon/bloc/moon_event.dart';
import 'package:go_moon/blocs/moon/bloc/moon_state.dart';
import 'package:go_moon/blocs/moon/moon_repository.dart';
import 'package:go_moon/blocs/moon/models/moon.dart';

class MoonBloc extends Bloc<MoonEvent, MoonState> {
  final MoonRepository _moonRepository;

  MoonBloc(this._moonRepository) : super(const MoonInitial()) {
    on<GetMoonData>(_onGetMoonData);
  }

  Future<void> _onGetMoonData(
      GetMoonData event, Emitter<MoonState> emit) async {
    try {
      emit(const MoonLoading());
      Moon moon = await _moonRepository.getMoonData();
      emit(MoonLoaded(moon));
    } catch (e) {
      emit(MoonError(e as String));
    }
  }
}
