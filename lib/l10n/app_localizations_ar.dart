import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hintSearchText => 'تمارين، مدربين، تمارين';

  @override
  String yourTrainingPlan(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'خطط التدريب الخاصة بك',
      one: 'خطة التدريب الخاصة بك',
    );
    return '$_temp0';
  }

  @override
  String get seeAll => 'عرض الكل';

  @override
  String recentTitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'video': 'فيديوهات حديثة',
        'training': 'خطط تدريب حديثة',
        'workout': 'تمارين حديثة',
        'search': 'بحوث حديثة',
        'visit': 'الزيارات الأخيرة',
        'audio': 'فصول صوتية',
        'other': 'لم يتم العثور على أي شيء',
      },
    );
    return '$_temp0';
  }

  @override
  String recentSubtitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'training': 'خطط رائعة',
        'workout': 'محتوى جديد لك',
        'other': 'لم يتم العثور على أي شيء',
      },
    );
    return '$_temp0';
  }

  @override
  String get nextUp => 'التالي';

  @override
  String get whatLookingFor => 'ما الذي تبحث عنه؟';

  @override
  String titleText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'video': 'فيديوهات',
        'training': 'خطط التدريب',
        'workout': 'تمارين',
        'audio': 'فصول صوتية',
        'other': 'لم يتم العثور على أي شيء',
      },
    );
    return '$_temp0';
  }

  @override
  String get cancelText => 'إلغاء';

  @override
  String get clearText => 'مسح';

  @override
  String get hintSearchText2 => 'اليوغا، HIIT، الهواء';

  @override
  String get levelText => 'المستوى';

  @override
  String get instructorText => 'المدرب';

  @override
  String get equipmentText => 'المعدات';

  @override
  String buttonText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'play': 'تشغيل الصف',
        'startWorkout': 'بدء التمرين',
        'letsGo': 'لنذهب',
        'previous': 'السابق',
        'nextWorkout': 'التمرين التالي',
        'startFollow': 'بدء المتابعة',
        'other': 'لم يتم العثور على أي شيء',
      },
    );
    return '$_temp0';
  }

  @override
  String get resetText => 'إعادة تعيين';

  @override
  String get filterText => 'تصفية';

  @override
  String get doneText => 'تم';

  @override
  String get goalText => 'الهدف';

  @override
  String get bodyPartText => 'أجزاء الجسم';

  @override
  String get alertBoxTitle => 'بدء التمرين خارج التسلسل؟';

  @override
  String get alertBoxBody => 'سيتم وضع علامة على أي تمارين غير مكتملة مدرجة قبل هذا التمرين على أنها مكتملة.';

  @override
  String get alertBoxButton1 => 'إلغاء';

  @override
  String get alertBoxButton2 => 'بدء التمرين';

  @override
  String get alertBoxTitle2 => 'الخروج من التمرين؟';

  @override
  String get alertBoxBody2 => 'لن تتمكن من استئناف التمرين.';

  @override
  String get alertBox2Button2 => 'الخروج';

  @override
  String get alertBoxTitle3 => 'إلغاء متابعة خطة التدريب؟';

  @override
  String get alertBoxBody3 => 'إذا قمت بإلغاء متابعة خطة التدريب، سيتم إزالة جميع التقدم.';

  @override
  String get alertBox3Button2 => 'إلغاء المتابعة';

  @override
  String phaseTitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'warmUp': 'الإحماء',
        'training': 'التدريب',
        'coolDown': 'تهدئة',
        'other': 'لم يتم العثور',
      },
    );
    return '$_temp0';
  }

  @override
  String get workoutText => 'تمرين';

  @override
  String get getReadyForText => 'استعد لـ';

  @override
  String get getReadyText => 'استعد!';

  @override
  String get durationText => 'المدة';

  @override
  String get typeText => 'النوع';

  @override
  String get whatYouNeedText => 'ما ستحتاجه';

  @override
  String get upNext => 'التالي';

  @override
  String get roundText => 'دائري';

  @override
  String get exerciseText => 'التمرين';

  @override
  String get overviewText => 'نظرة عامة';

  @override
  String get trainerNotesText => 'ملاحظات المدرب';

  @override
  String get repsText => 'المرات';

  @override
  String get timeText => 'الزمن';

  @override
  String get trainingAll => 'الكل';

  @override
  String get trainingFollow => 'متابعة';

  @override
  String workoutPluraText(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'تمارين',
      one: 'تمرين',
    );
    return '$_temp0';
  }

  @override
  String get followingText => 'متابعة';

  @override
  String get nextText => 'التالي';

  @override
  String get completeText => 'لقد أكملت';

  @override
  String get totalDurationText => 'المدة الكلية';

  @override
  String get progressUpdateText => 'تحديث التقدم';

  @override
  String get completedFollowPlan => 'لقد أكملت خطة التدريب وسيتم إزالتها من الخطط المتابعة الخاصة بك. إذا كنت ترغب في متابعتها مرة أخرى يمكنك النقر على \'ابدأ من جديد\' أدناه.';

  @override
  String get startAgainText => 'ابدأ من جديد';

  @override
  String get unFollowTrainingPlanText => 'إلغاء متابعة خطة التدريب';

  @override
  String get scheduleText => 'الجدول';

  @override
  String get nothingToLoadText => 'لا يوجد شيء للتحميل';

  @override
  String get minText => 'دقيقة';

  @override
  String get workoutOverviewText => 'نظرة عامة على التمرين';

  @override
  String get workoutCompletedText => 'تمت المجموعة';

  @override
  String popupText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'show': 'عرض المعلومات',
        'here': 'اذهب هنا',
        'other': 'غير موجود',
      },
    );
    return '$_temp0';
  }

  @override
  String itemTypeInfo(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'single': 'يمكن دمج التمارين في مجموعات متعددة مع مقاييس مختلفة متصلة بها.',
        'circuit': 'الدائرة الزمنية هي مجموعة من التمارين المُنفَذة مع فترة عمل-راحة محددة. يمكن أن يحتوي كل جولة على فترة عمل-راحة مختلفة و/أو تمارين مختلفة.',
        'reps': 'الدائرة المبنية على التكرار هي مجموعة من التمارين المُنفَذة مع فترات راحة قصيرة بينها لعدد محدد من التكرارات. يمكن أن تحتوي كل جولة على عدد مختلف من التكرارات وفترة الراحة و/أو التمارين.',
        'ss': 'مفهوم السوبيرسيت هو أداء تمرينين متتاليين، تليهما راحة قصيرة (ولكن ليس دائمًا).',
        'rft': 'اختصار RFT لـ \'جولات لمدة زمنية\'. يحتاج المشاركون إلى إكمال عدد معين من الجولات والتكرارات في أقرب وقت ممكن. جولة هي تسلسل من جميع التمارين. الوقت الذي يستغرقه المشاركون لإكمال العدد المحدد من الجولات هو درجتهم.',
        'amrap': 'اختصار AMRAP لـ \'كم عدد التكرارات الممكنة\'. يحتاج المشاركون إلى إكمال أكبر عدد ممكن من التكرارات للتمرين المعطى في فترة زمنية محددة. عدد الرمات التامة من التكرارات هو درجة المشارك.',
        'enom': 'اختصار EMOM لـ \'كل دقيقة في الدقيقة\'. في هذا النوع من التمرين، يجب على المشارك أن يكمل التمارين في بداية كل دقيقة لعدد محدد من الدقائق. يمكن أن تحتوي كل دقيقة على تمارين مختلفة بقيم مختلفة.',
        'other': 'غير موجود',
      },
    );
    return '$_temp0';
  }
}
