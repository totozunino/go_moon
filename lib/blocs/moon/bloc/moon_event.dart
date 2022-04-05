import 'package:equatable/equatable.dart';

abstract class MoonEvent extends Equatable {
  const MoonEvent();

  @override
  List<Object?> get props => [];
}

class GetMoonData extends MoonEvent {
  const GetMoonData();
}
