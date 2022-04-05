import 'package:equatable/equatable.dart';
import 'package:go_moon/blocs/moon/models/moon.dart';

abstract class MoonState extends Equatable {
  const MoonState();

  @override
  List<Object?> get props => [];
}

class MoonInitial extends MoonState {
  const MoonInitial();
}

class MoonLoading extends MoonState {
  const MoonLoading();
}

class MoonLoaded extends MoonState {
  final Moon moon;

  const MoonLoaded(this.moon);
}

class MoonError extends MoonState {
  final String? message;

  const MoonError(this.message);
}
