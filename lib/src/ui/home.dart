

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

class UiToolKitSDK extends StatefulWidget {
  final String token;
  const UiToolKitSDK({
    super.key,
    required this.token,
  });

  @override
  State<UiToolKitSDK> createState() => _UiToolKitSDKState();
}

class _UiToolKitSDKState extends State<UiToolKitSDK> {
  @override
  void initState() {
    getPath();
    setToken();
    super.initState();
  }

  getPath() async {
    await PkgAppController.getPath();
  }

  setToken() {
    BearerToken.setToken = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OnDemandModel> onDemadDataVideo = [];
  List<WorkoutModel> workoutData = [];
  List<OnDemandModel> onDemadDataAudio = [];
  List<TrainingPlanModel> trainingPlanData = [];
  Map<int, String> workoutDataType = {};
  Map<int, String> videoDataType = {};
  Map<int, String> audioDataType = {};
  Map<int, String> fitnessGoalData = {};
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    fetchData();


    super.initState();
  }

  fetchData() async {
    await DashBoardController.getData(context,
        audioDataType: audioDataType,
        videoDataType: videoDataType,
        workoutDataType: workoutDataType,
        isLoading: isLoading,
        onDemadDataVideo: onDemadDataVideo,
        audioData: onDemadDataAudio,
        workoutData: workoutData,
        trainingPlanData: trainingPlanData,
        fitnessGoalData: fitnessGoalData);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return FutureBuilder(
              future: Connectivity().checkConnectivity(),
              builder: (context, future) {
        
                return Scaffold(
                    backgroundColor: AppColor.borderBrandDarkColor,
                    body: ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (_, value, child) {
                          return value == true
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Container(
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                  AppAssets.logo,
                                                ))),
                                      ),
                                      20.height(),
                                      const Center(child: ThreeDotLoader()),
                                    ])
                              : DashBoardView(
                                  onDemadDataVideo: onDemadDataVideo,
                                  workoutData: workoutData,
                                  onDemadDataAudio: onDemadDataAudio,
                                  trainingPlanData: trainingPlanData,
                                  workoutDataType: workoutDataType,
                                  videoDataType: videoDataType,
                                  audioDataType: audioDataType,
                                  fitnessGoalData: fitnessGoalData);
                        }),
                    bottomNavigationBar: snapshot.data ==
                                ConnectivityResult.none ||
                            future.data == ConnectivityResult.none
                        ? Container(
                            alignment: Alignment.center,
                            color: AppColor.redColor,
                            height: 30,
                            width: double.infinity,
                            child: Text(
                              'No Internet',
                              style: AppTypography.title18LG
                                  .copyWith(color: AppColor.textInvertEmphasis),
                            ),
                          )
                        : null);
              });
        });
  }
}


class ThreeDotLoader extends StatefulWidget {
  const ThreeDotLoader({super.key});

  @override
  _ThreeDotLoaderState createState() => _ThreeDotLoaderState();
}

class _ThreeDotLoaderState extends State<ThreeDotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;
  late Animation<double> _animation5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _animation1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _animation2 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );

    _animation3 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.0, curve: Curves.easeInOut),
      ),
    );
    _animation4 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );
    _animation5 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation1,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation1.value,
                child: child,
              );
            },
            child: const Dot(),
          ),
          const SizedBox(width: 10),
          AnimatedBuilder(
            animation: _animation2,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation2.value,
                child: child,
              );
            },
            child: const Dot(),
          ),
          const SizedBox(width: 10),
          AnimatedBuilder(
            animation: _animation3,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation3.value,
                child: child,
              );
            },
            child: const Dot(),
          ),
          const SizedBox(width: 10),
          AnimatedBuilder(
            animation: _animation4,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation4.value,
                child: child,
              );
            },
            child: const Dot(),
          ),
          const SizedBox(width: 10),
          AnimatedBuilder(
            animation: _animation5,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation5.value,
                child: child,
              );
            },
            child: const Dot(),
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.textInvertEmphasis,
      ),
    );
  }
}
