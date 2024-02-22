import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @hintSearchText.
  ///
  /// In en, this message translates to:
  /// **'Workouts, trainers, exercises'**
  String get hintSearchText;

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{length, plural,  =1{Your Training Plan} other{Your Training Plans}}'**
  String yourTrainingPlan(num length);

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @recentTitle.
  ///
  /// In en, this message translates to:
  /// **'{title, select, video{Recent Video Classes} training{Recent Training Plans} workout{Recent Workouts} search{Recent Searches} visit{Recently Visited} audio{Audio Classes} other{no found any}}'**
  String recentTitle(String title);

  /// Which type of recent subtitle message
  ///
  /// In en, this message translates to:
  /// **'{title, select, training{Sweet sweet plans} workout{Some fresh content for you} other{not found any}}'**
  String recentSubtitle(String title);

  /// No description provided for @nextUp.
  ///
  /// In en, this message translates to:
  /// **'Next up'**
  String get nextUp;

  /// No description provided for @whatLookingFor.
  ///
  /// In en, this message translates to:
  /// **'What Are You Looking For?'**
  String get whatLookingFor;

  /// Title
  ///
  /// In en, this message translates to:
  /// **'{title, select, video{Video Classes} training{Training Plans} workout{Workouts} audio{Audio Classes} other{not found any}}'**
  String titleText(String title);

  /// No description provided for @cancelText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelText;

  /// No description provided for @clearText.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearText;

  /// No description provided for @hintSearchText2.
  ///
  /// In en, this message translates to:
  /// **'Yoga, HIIT, cardio'**
  String get hintSearchText2;

  /// No description provided for @levelText.
  ///
  /// In en, this message translates to:
  /// **'level'**
  String get levelText;

  /// No description provided for @instructorText.
  ///
  /// In en, this message translates to:
  /// **'Instructor'**
  String get instructorText;

  /// No description provided for @equipmentText.
  ///
  /// In en, this message translates to:
  /// **'Equippment'**
  String get equipmentText;

  /// Button Title
  ///
  /// In en, this message translates to:
  /// **'{title, select, play{Play class} startWorkout{Start Workout} letsGo{Let\'s go} previous{Prev} nextWorkout{Next Workout} startFollow{Start Following} other{not found any}}'**
  String buttonText(String title);

  /// No description provided for @resetText.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetText;

  /// No description provided for @filterText.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterText;

  /// No description provided for @doneText.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneText;

  /// No description provided for @goalText.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goalText;

  /// No description provided for @bodyPartText.
  ///
  /// In en, this message translates to:
  /// **'Bodyparts'**
  String get bodyPartText;

  /// No description provided for @alertBoxTitle.
  ///
  /// In en, this message translates to:
  /// **'Start workout out of sequence?'**
  String get alertBoxTitle;

  /// No description provided for @alertBoxBody.
  ///
  /// In en, this message translates to:
  /// **'Any incomplete workouts listed before this one will be marked as complete.'**
  String get alertBoxBody;

  /// No description provided for @alertBoxButton1.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get alertBoxButton1;

  /// No description provided for @alertBoxButton2.
  ///
  /// In en, this message translates to:
  /// **'Start Workout'**
  String get alertBoxButton2;

  /// No description provided for @alertBoxTitle2.
  ///
  /// In en, this message translates to:
  /// **'Quit workout?'**
  String get alertBoxTitle2;

  /// No description provided for @alertBoxBody2.
  ///
  /// In en, this message translates to:
  /// **'You will not be able to resume the workout.'**
  String get alertBoxBody2;

  /// No description provided for @alertBox2Button2.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get alertBox2Button2;

  /// No description provided for @alertBoxTitle3.
  ///
  /// In en, this message translates to:
  /// **'Unfollow training plan?'**
  String get alertBoxTitle3;

  /// No description provided for @alertBoxBody3.
  ///
  /// In en, this message translates to:
  /// **'If you unfollow the training plan all progress will be removed'**
  String get alertBoxBody3;

  /// No description provided for @alertBox3Button2.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get alertBox3Button2;

  /// No description provided for @phaseTitle.
  ///
  /// In en, this message translates to:
  /// **'{title, select, warmUp{Warmup} training{Training} coolDown{CoolDown} other{no found}}'**
  String phaseTitle(String title);

  /// No description provided for @workoutText.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get workoutText;

  /// No description provided for @getReadyForText.
  ///
  /// In en, this message translates to:
  /// **'Get ready for'**
  String get getReadyForText;

  /// No description provided for @getReadyText.
  ///
  /// In en, this message translates to:
  /// **'Get Ready!'**
  String get getReadyText;

  /// No description provided for @durationText.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationText;

  /// No description provided for @typeText.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeText;

  /// No description provided for @whatYouNeedText.
  ///
  /// In en, this message translates to:
  /// **'What you\'ll need'**
  String get whatYouNeedText;

  /// No description provided for @upNext.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get upNext;

  /// No description provided for @roundText.
  ///
  /// In en, this message translates to:
  /// **'ROUND'**
  String get roundText;

  /// No description provided for @exerciseText.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE'**
  String get exerciseText;

  /// No description provided for @overviewText.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewText;

  /// No description provided for @trainerNotesText.
  ///
  /// In en, this message translates to:
  /// **'Trainer notes'**
  String get trainerNotesText;

  /// No description provided for @repsText.
  ///
  /// In en, this message translates to:
  /// **'REPS'**
  String get repsText;

  /// No description provided for @timeText.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get timeText;

  /// No description provided for @trainingAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get trainingAll;

  /// No description provided for @trainingFollow.
  ///
  /// In en, this message translates to:
  /// **'Followed'**
  String get trainingFollow;

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{length, plural,  =1{workout} other{workouts}}'**
  String workoutPluraText(num length);

  /// No description provided for @followingText.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get followingText;

  /// No description provided for @nextText.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextText;

  /// No description provided for @completeText.
  ///
  /// In en, this message translates to:
  /// **'You’ve completed'**
  String get completeText;

  /// No description provided for @totalDurationText.
  ///
  /// In en, this message translates to:
  /// **'Total Duration'**
  String get totalDurationText;

  /// No description provided for @progressUpdateText.
  ///
  /// In en, this message translates to:
  /// **'Progress update'**
  String get progressUpdateText;

  /// No description provided for @completedFollowPlan.
  ///
  /// In en, this message translates to:
  /// **'\'You have completed the training plan and it will be removed from your followed training plans. If you wish to follow it again you can click “Start again” below.'**
  String get completedFollowPlan;

  /// No description provided for @startAgainText.
  ///
  /// In en, this message translates to:
  /// **'Start again'**
  String get startAgainText;

  /// No description provided for @unFollowTrainingPlanText.
  ///
  /// In en, this message translates to:
  /// **'Unfollow training plan'**
  String get unFollowTrainingPlanText;

  /// No description provided for @scheduleText.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleText;

  /// No description provided for @nothingToLoadText.
  ///
  /// In en, this message translates to:
  /// **'Nothing to load'**
  String get nothingToLoadText;

  /// No description provided for @minText.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minText;

  /// No description provided for @workoutOverviewText.
  ///
  /// In en, this message translates to:
  /// **'Workout Overview'**
  String get workoutOverviewText;

  /// No description provided for @workoutCompletedText.
  ///
  /// In en, this message translates to:
  /// **'Workouts completed'**
  String get workoutCompletedText;

  /// A popup buttonText
  ///
  /// In en, this message translates to:
  /// **'{title, select, show{Show info} here{Go here} other{no found}}'**
  String popupText(String title);

  /// No description provided for @itemTypeInfo.
  ///
  /// In en, this message translates to:
  /// **'{title, select, single{Exercises can be combined into multiple sets with different metrics connected to it.} circuit{A time-based circuit is a combination of exercises performed with a prescribed work-rest interval. Each round can have a different work-rest interval and/or different exercises.} reps{A repetition-based circuit is a combination of exercises performed with short rest periods between them for a set number of repetitions. Each round can have a different number of reps, rest interval, and/or exercises.} ss{The concept of a superset is to perform 2 exercises back to back, followed by a short rest (but not always).} rft{RFT is short for \'rounds for time\'. Participants need to complete the set amount of rounds and reps as soon as possible. A round is a sequence of all exercises. The time it takes the participants to complete the set number of rounds is their score.} amrap{AMRAP is short for \'as many reps as possible\'. Participants need to complete as many repetitions of the given exercise sequence in a set amount of time. The total number of repetitions completed is the participant\'s score.} enom{EMOM is short for \'every minute on the minute\'. In this type of workout, the participant has to complete the exercises at the start of every minute for a set number of minutes. Each minute can have different exercises with different values.} other{no found} }'**
  String itemTypeInfo(String title);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
