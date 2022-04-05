import 'package:bloc_test/bloc_test.dart';
import 'package:go_moon/blocs/moon/bloc/moon_bloc.dart';
import 'package:go_moon/blocs/moon/bloc/moon_event.dart';
import 'package:go_moon/blocs/moon/bloc/moon_state.dart';
import 'package:go_moon/blocs/moon/models/moon.dart';
import 'package:go_moon/blocs/moon/moon_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'moon_test.mocks.dart';

@GenerateMocks([MoonRepository])
void main() {
  group('MoonBloc', () {
    late MoonBloc moonBloc;
    late MockMoonRepository moonRepository;
    Moon moon = const Moon(phase: 'Full Moon', ilumination: 10);

    setUp(() {
      moonRepository = MockMoonRepository();
      moonBloc = MoonBloc(
        moonRepository,
      );
    });

    tearDown(() {
      moonBloc.close();
    });

    test('Initial state for the Moon bloc', () {
      expect(moonBloc.state, const MoonInitial());
    });

    blocTest(
      'Moon bloc should get moon data successfully and emit state with moon loaded',
      build: () {
        when(moonRepository.getMoonData()).thenAnswer(
          (_) async => moon,
        );

        return MoonBloc(moonRepository);
      },
      act: (MoonBloc bloc) => bloc
        ..add(
          const GetMoonData(),
        ),
      expect: () => [
        const MoonLoading(),
        MoonLoaded(moon),
      ],
    );

    blocTest(
      'Moon bloc should display error message successfully and emit state with moon error',
      build: () {
        when(moonRepository.getMoonData()).thenThrow("Failed to load moon");

        return MoonBloc(moonRepository);
      },
      act: (MoonBloc bloc) => bloc
        ..add(
          const GetMoonData(),
        ),
      expect: () => [
        const MoonLoading(),
        const MoonError("Failed to load moon"),
      ],
    );
  });
}
