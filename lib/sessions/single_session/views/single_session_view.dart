import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/sessions.dart';
import 'package:quickalert/quickalert.dart';
import 'package:session_repository/session_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SingleSessionView extends StatelessWidget {
  const SingleSessionView({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SingleSessionCubit()..getSession(sessionId),
      child: SingleSesionContent(
        sessionId: sessionId,
      ),
    );
  }
}

class SingleSesionContent extends StatelessWidget {
  const SingleSesionContent({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SingleSessionCubit, SingleSessionState>(
      listener: (context, state) {
        if (state.status == SingleSessionStatus.deleted) {
          context.read<ListSessionsCubit>().removeSession(state.session.id!);
        }

        if (state.status == SingleSessionStatus.failure) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oups !',
            text: 'Something went wrong',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Session details'),
          elevation: 4,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              title: 'Delete session',
              text: 'Are you sure you want to delete this session ?',
              confirmBtnText: 'Yes',
              cancelBtnText: 'No',
              showCancelBtn: true,
              onConfirmBtnTap: () {
                context.read<SingleSessionCubit>().deleteSession();
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context).pop();
              },
            );
          },
          child: const Icon(Icons.delete_forever),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: BlocBuilder<SingleSessionCubit, SingleSessionState>(
                builder: (context, state) {
                  List<LapData> data = LapsUtils.toLapsData(state.session.laps);

                  if (state.session == Session.empty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          Text(state.session.circuit.name),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.directions_car),
                          Text(state.session.kart.name),
                        ],
                      ),
                      Row(
                        children: [
                          WeatherUtils.getWeatherIcon(state.session.weather),
                          const SizedBox(width: 16),
                          Text('${state.session.weather['temperature']}°C'),
                          const SizedBox(width: 16),
                          Text(TimeUtils.formatDate(state.session.date)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer),
                          const SizedBox(width: 16),
                          Text(TimeUtils.formatDuration(LapsUtils.getBestLap(state.session.laps).duration)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SfCartesianChart(
                          onDataLabelRender: (DataLabelRenderArgs args) {
                            args.text = data[args.pointIndex! as int].display;
                          },
                          onTooltipRender: (TooltipArgs args) {
                            args.text = data[args.pointIndex! as int].display;
                          },
                          primaryXAxis: CategoryAxis(
                            title: AxisTitle(text: 'Laps'),
                          ),
                          onTrackballPositionChanging: (TrackballArgs trackballArgs) {
                            trackballArgs.chartPointInfo.label =
                                data[trackballArgs.chartPointInfo.dataPointIndex!].display;
                          },
                          primaryYAxis: NumericAxis(
                            axisLabelFormatter: (axisLabelRenderArgs) => ChartAxisLabel(
                              TimeUtils.formatDuration(axisLabelRenderArgs.value.toInt()),
                              const TextStyle(color: Colors.black),
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                          trackballBehavior: TrackballBehavior(
                            enable: true,
                            activationMode: ActivationMode.singleTap,
                          ),
                          series: [
                            LineSeries<LapData, int>(
                              dataSource: data,
                              xValueMapper: (LapData lap, _) => lap.index,
                              yValueMapper: (LapData lap, _) => lap.duration,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
