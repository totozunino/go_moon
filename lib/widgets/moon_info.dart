import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_moon/blocs/moon/bloc/moon_bloc.dart';
import 'package:go_moon/blocs/moon/bloc/moon_event.dart';
import 'package:go_moon/blocs/moon/bloc/moon_state.dart';
import 'package:go_moon/blocs/moon/moon_repository.dart';
import 'package:go_moon/utils/utils.dart';
import 'package:go_moon/widgets/clock_timer.dart';

class MoonInfo extends StatelessWidget {
  const MoonInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoonBloc(
        context.read<MoonRepository>(),
      )..add(const GetMoonData()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ClockTimer(),
          const SizedBox(
            height: 65,
          ),
          BlocBuilder<MoonBloc, MoonState>(
            builder: (context, state) {
              if (state is MoonLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              if (state is MoonLoaded) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200.withOpacity(0.2),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SizedBox(
                        child: Image.asset(
                          "assets/images/${toSnakeCase(state.moon.phase)}.png",
                          fit: BoxFit.cover,
                          width: 82,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      state.moon.phase,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ilumination ${state.moon.ilumination}%",
                    ),
                    const SizedBox(
                      height: 85,
                    ),
                  ],
                );
              }

              if (state is MoonError) {
                return Column(
                  children: [
                    SizedBox(
                      child: Image.asset(
                        "assets/images/error.png",
                        fit: BoxFit.cover,
                        width: 82,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(state.message!),
                  ],
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
