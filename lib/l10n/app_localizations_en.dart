import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hintSearchText => 'Workouts, trainers, exercises';

  @override
  String yourTrainingPlan(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'Your Training Plans',
      one: 'Your Training Plan',
    );
    return '$_temp0';
  }

  @override
  String get seeAll => 'See all';

  @override
  String recentTitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'video': 'Recent Video Classes',
        'training': 'Recent Training Plans',
        'workout': 'Recent Workouts',
        'search': 'Recent Searches',
        'visit': 'Recently Visited',
        'audio': 'Audio Classes',
        'other': 'no found any',
      },
    );
    return '$_temp0';
  }

  @override
  String recentSubtitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'training': 'Sweet sweet plans',
        'workout': 'Some fresh content for you',
        'other': 'not found any',
      },
    );
    return '$_temp0';
  }

  @override
  String get nextUp => 'Next up';

  @override
  String get whatLookingFor => 'What Are You Looking For?';

  @override
  String titleText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'video': 'Video Classes',
        'training': 'Training Plans',
        'workout': 'Workouts',
        'audio': 'Audio Classes',
        'other': 'not found any',
      },
    );
    return '$_temp0';
  }

  @override
  String get cancelText => 'Cancel';

  @override
  String get clearText => 'Clear';

  @override
  String get hintSearchText2 => 'Yoga, HIIT, cardio';

  @override
  String get levelText => 'level';

  @override
  String get instructorText => 'Instructor';

  @override
  String get equipmentText => 'Equippment';

  @override
  String buttonText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'play': 'Play class',
        'startWorkout': 'Start Workout',
        'letsGo': 'Let\'s go',
        'previous': 'Prev',
        'nextWorkout': 'Next Workout',
        'startFollow': 'Start Following',
        'other': 'not found any',
      },
    );
    return '$_temp0';
  }

  @override
  String get resetText => 'Reset';

  @override
  String get filterText => 'Filter';

  @override
  String get doneText => 'Done';

  @override
  String get goalText => 'Goal';

  @override
  String get bodyPartText => 'Bodyparts';

  @override
  String get alertBoxTitle => 'Start workout out of sequence?';

  @override
  String get alertBoxBody => 'Any incomplete workouts listed before this one will be marked as complete.';

  @override
  String get alertBoxButton1 => 'Cancel';

  @override
  String get alertBoxButton2 => 'Start Workout';

  @override
  String get alertBoxTitle2 => 'Quit workout?';

  @override
  String get alertBoxBody2 => 'You will not be able to resume the workout.';

  @override
  String get alertBox2Button2 => 'Quit';

  @override
  String get alertBoxTitle3 => 'Unfollow training plan?';

  @override
  String get alertBoxBody3 => 'If you unfollow the training plan all progress will be removed';

  @override
  String get alertBox3Button2 => 'Unfollow';

  @override
  String phaseTitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'warmUp': 'Warmup',
        'training': 'Training',
        'coolDown': 'CoolDown',
        'other': 'no found',
      },
    );
    return '$_temp0';
  }

  @override
  String get workoutText => 'Workout';

  @override
  String get getReadyForText => 'Get ready for';

  @override
  String get getReadyText => 'Get Ready!';

  @override
  String get durationText => 'Duration';

  @override
  String get typeText => 'Type';

  @override
  String get whatYouNeedText => 'What you\'ll need';

  @override
  String get upNext => 'Up next';

  @override
  String get roundText => 'ROUND';

  @override
  String get exerciseText => 'EXERCISE';

  @override
  String get overviewText => 'Overview';

  @override
  String get trainerNotesText => 'Trainer notes';

  @override
  String get repsText => 'REPS';

  @override
  String get timeText => 'TIME';

  @override
  String get trainingAll => 'All';

  @override
  String get trainingFollow => 'Followed';

  @override
  String workoutPluraText(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'workouts',
      one: 'workout',
    );
    return '$_temp0';
  }

  @override
  String get followingText => 'Following';

  @override
  String get nextText => 'Next';

  @override
  String get completeText => 'You’ve completed';

  @override
  String get totalDurationText => 'Total Duration';

  @override
  String get progressUpdateText => 'Progress update';

  @override
  String get completedFollowPlan => '\'You have completed the training plan and it will be removed from your followed training plans. If you wish to follow it again you can click “Start again” below.';

  @override
  String get startAgainText => 'Start again';

  @override
  String get unFollowTrainingPlanText => 'Unfollow training plan';

  @override
  String get scheduleText => 'Schedule';

  @override
  String get nothingToLoadText => 'Nothing to load';

  @override
  String get minText => 'min';

  @override
  String get workoutOverviewText => 'Workout Overview';

  @override
  String get workoutCompletedText => 'Workouts completed';

  @override
  String popupText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'show': 'Show info',
        'here': 'Go here',
        'other': 'no found',
      },
    );
    return '$_temp0';
  }

  @override
  String itemTypeInfo(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'single': 'Exercises can be combined into multiple sets with different metrics connected to it.',
        'circuit': 'A time-based circuit is a combination of exercises performed with a prescribed work-rest interval. Each round can have a different work-rest interval and/or different exercises.',
        'reps': 'A repetition-based circuit is a combination of exercises performed with short rest periods between them for a set number of repetitions. Each round can have a different number of reps, rest interval, and/or exercises.',
        'ss': 'The concept of a superset is to perform 2 exercises back to back, followed by a short rest (but not always).',
        'rft': 'RFT is short for \'rounds for time\'. Participants need to complete the set amount of rounds and reps as soon as possible. A round is a sequence of all exercises. The time it takes the participants to complete the set number of rounds is their score.',
        'amrap': 'AMRAP is short for \'as many reps as possible\'. Participants need to complete as many repetitions of the given exercise sequence in a set amount of time. The total number of repetitions completed is the participant\'s score.',
        'enom': 'EMOM is short for \'every minute on the minute\'. In this type of workout, the participant has to complete the exercises at the start of every minute for a set number of minutes. Each minute can have different exercises with different values.',
        'other': 'no found',
      },
    );
    return '$_temp0';
  }
}
