import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:funxtion/funxtion_sdk.dart';

import '../../ui_tool_kit.dart';

final videoProvider = ChangeNotifierProvider<VideoProviderNotifier>((ref) {
  return VideoProviderNotifier();
});

class VideoProviderNotifier extends ChangeNotifier {
  int pageNumber = 1;

  int limitContentPerPage = 20;

  List<OnDemandModel> data = [];

  bool nextPage = true;

  bool isLoadMore = false;
  Future<List<OnDemandModel>?> getData(context, {String? mainSearch}) async {
    print(pageNumber);
    try {
      EasyLoading.show();
      List<OnDemandModel> fetcheddata = await OnDemandRequest.listOnDemand(
        // whereCategoriesIdsAre: '',
        whereDurationIsEqualTo:
            searchFilter('duration')?.map((e) => e).toString(),
        // whereEquipmentIdIsEqualTo: '',
        // whereEquipmentIdsAre: '',
        // whereInstructorsIdIsEqualTo: '',
        // whereInstructorsIdsAre: '',
        whereLimitContentPerPageIsEqualTo: limitContentPerPage.toString(),
        whereLocationIsEqualTo:
            searchFilter('location')?.map((e) => e).toString(),
        whereNameIsEqualTo: mainSearch,
        // whereOrderingAccordingToNameEqualTo: '',
        whereLevelFieldEqualTo: searchFilter('level')?.map((e) => e).toString(),
        // fuzzyFilterSearch: mainSearch,
        wherePageNumberIsEqualTo: pageNumber.toString(),
      ) as List<OnDemandModel>;

      if (fetcheddata.isEmpty) {
        nextPage = false;
        notifyListeners();

        return null;
      } else {
        data.addAll(fetcheddata);

        isLoadMore = false;
        notifyListeners();
        EasyLoading.dismiss();
        return fetcheddata;
      }
    } on RequestException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return null;
  }

  List<String>? searchFilter(String type) {
    List<String> filters = [];
    if (confirmedFilter != null) {
      for (var element in confirmedFilter!) {
        if (element.type == type) {
          filters.add(element.filter);
        }
      }

      return filters;
    }
    return null;
  }

  List<IconTextModel> level = [
    IconTextModel(text: 'Beginner', imageName: AppAssets.chartLowIcon),
    IconTextModel(text: 'Medium', imageName: AppAssets.chatMidIcon),
    IconTextModel(text: 'Advanced', imageName: AppAssets.chartFullIcon),
  ];
  List<IconTextModel> duration = [
    IconTextModel(
      text: '10 min',
    ),
    IconTextModel(
      text: '20 min',
    ),
    IconTextModel(
      text: '30 min',
    ),
    IconTextModel(
      text: '45 min',
    )
  ];

  List<IconTextModel> location = [
    IconTextModel(text: 'Home', imageName: AppAssets.homeIcon),
    IconTextModel(text: 'Gym', imageName: AppAssets.gymIcon),
    IconTextModel(text: 'Outdoor', imageName: AppAssets.outdoorIcon),
  ];
  List<IconTextModel> type = [
    IconTextModel(
      text: 'Yoga',
    ),
    IconTextModel(
      text: 'HIIT',
    ),
    IconTextModel(
      text: 'Strength',
    ),
    IconTextModel(
      text: 'Cardio',
    ),
    IconTextModel(
      text: 'Pilates',
    ),
    IconTextModel(
      text: 'Disco',
    )
  ];
  List<TypeFilterModel> selectedFilter = [];
  List<TypeFilterModel>? confirmedFilter;
  void deleteAFilter(context, String e) {
    confirmedFilter?.removeWhere((element) => element.filter == e);
    getData(context);
    notifyListeners();
  }

  void addFilter(TypeFilterModel value) {
    if (selectedFilter.any((element) => element.filter == value.filter)) {
      selectedFilter.removeWhere((element) => element.filter == value.filter);
      notifyListeners();
      return;
    } else {
      selectedFilter.add(value);
      notifyListeners();
      return;
    }
  }

  bool isShowFilter = false;
  void showAllFiltter() {
    isShowFilter = true;
    notifyListeners();
  }

  void hideAllFilter() {
    isShowFilter = false;
    notifyListeners();
  }

  void resetFilter() {
    selectedFilter.clear();
    notifyListeners();
  }

  void confirmFilter(BuildContext context) {
    confirmedFilter = selectedFilter;
    getData(context);
    print(searchFilter('duration')?.map((e) => e));
    print(searchFilter('location')?.map((e) => e));
    notifyListeners();
  }

  Timer? timer;
  void delayedFunction(context, {required String value}) async {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }

    timer = Timer(const Duration(milliseconds: 400), () {
      getData(context, mainSearch: value);
    });
  }
}

class IconTextModel {
  final String text;
  final String? imageName;

  IconTextModel({required this.text, this.imageName});
}

class TypeFilterModel {
  final String type;
  final String filter;

  TypeFilterModel({
    required this.type,
    required this.filter,
  });
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
