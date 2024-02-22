import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get hintSearchText => 'Allenamenti, istruttori, esercizi';

  @override
  String yourTrainingPlan(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'I tuoi piani di allenamento',
      one: 'Il tuo piano di allenamento',
    );
    return '$_temp0';
  }

  @override
  String get seeAll => 'Vedi tutto';

  @override
  String recentTitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'video': 'Classi video recenti',
        'training': 'Piani di allenamento recenti',
        'workout': 'Allenamenti recenti',
        'search': 'Ricerche recenti',
        'visit': 'Visitati di recente',
        'audio': 'Classi audio',
        'other': 'nessun elemento trovato',
      },
    );
    return '$_temp0';
  }

  @override
  String recentSubtitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'training': 'Piani dolci dolci',
        'workout': 'Qualche contenuto fresco per te',
        'other': 'nessun elemento trovato',
      },
    );
    return '$_temp0';
  }

  @override
  String get nextUp => 'Prossimo';

  @override
  String get whatLookingFor => 'Cosa stai cercando?';

  @override
  String titleText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'video': 'Classi video',
        'training': 'Piani di allenamento',
        'workout': 'Allenamenti',
        'audio': 'Classi audio',
        'other': 'nessun elemento trovato',
      },
    );
    return '$_temp0';
  }

  @override
  String get cancelText => 'Annulla';

  @override
  String get clearText => 'Cancella';

  @override
  String get hintSearchText2 => 'Yoga, HIIT, cardio';

  @override
  String get levelText => 'Livello';

  @override
  String get instructorText => 'Istruttore';

  @override
  String get equipmentText => 'Attrezzatura';

  @override
  String buttonText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'play': 'Riproduci classe',
        'startWorkout': 'Inizia allenamento',
        'letsGo': 'Andiamo',
        'previous': 'Prec',
        'nextWorkout': 'Prossimo allenamento',
        'startFollow': 'Inizia a seguire',
        'other': 'nessun elemento trovato',
      },
    );
    return '$_temp0';
  }

  @override
  String get resetText => 'Ripristina';

  @override
  String get filterText => 'Filtra';

  @override
  String get doneText => 'Fatto';

  @override
  String get goalText => 'Obiettivo';

  @override
  String get bodyPartText => 'Parti del corpo';

  @override
  String get alertBoxTitle => 'Iniziare l\'allenamento fuori sequenza?';

  @override
  String get alertBoxBody => 'Eventuali allenamenti incompleti elencati prima di questo verranno contrassegnati come completati.';

  @override
  String get alertBoxButton1 => 'Annulla';

  @override
  String get alertBoxButton2 => 'Inizia allenamento';

  @override
  String get alertBoxTitle2 => 'Abbandonare l\'allenamento?';

  @override
  String get alertBoxBody2 => 'Non sarà possibile riprendere l\'allenamento.';

  @override
  String get alertBox2Button2 => 'Abbandona';

  @override
  String get alertBoxTitle3 => 'Annullare il piano di allenamento?';

  @override
  String get alertBoxBody3 => 'Se annulli il piano di allenamento, tutti i progressi verranno rimossi';

  @override
  String get alertBox3Button2 => 'Annulla';

  @override
  String phaseTitle(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'warmUp': 'Riscaldamento',
        'training': 'Allenamento',
        'coolDown': 'Raffreddamento',
        'other': 'nessun elemento trovato',
      },
    );
    return '$_temp0';
  }

  @override
  String get workoutText => 'Allenamento';

  @override
  String get getReadyForText => 'Preparati per';

  @override
  String get getReadyText => 'Preparati!';

  @override
  String get durationText => 'Durata';

  @override
  String get typeText => 'Tipo';

  @override
  String get whatYouNeedText => 'Cosa ti serve';

  @override
  String get upNext => 'Prossimo';

  @override
  String get roundText => 'Girare';

  @override
  String get exerciseText => 'ESERCIZIO';

  @override
  String get overviewText => 'Panoramica';

  @override
  String get trainerNotesText => 'Note dell\'istruttore';

  @override
  String get repsText => 'RIPETIZIONI';

  @override
  String get timeText => 'TEMPO';

  @override
  String get trainingAll => 'Tutto';

  @override
  String get trainingFollow => 'Seguito';

  @override
  String workoutPluraText(num length) {
    String _temp0 = intl.Intl.pluralLogic(
      length,
      locale: localeName,
      other: 'allenamenti',
      one: 'allenamento',
    );
    return '$_temp0';
  }

  @override
  String get followingText => 'Seguito';

  @override
  String get nextText => 'Avanti';

  @override
  String get completeText => 'Hai completato';

  @override
  String get totalDurationText => 'Durata totale';

  @override
  String get progressUpdateText => 'Aggiornamento progressi';

  @override
  String get completedFollowPlan => 'Hai completato il piano di allenamento e verrà rimosso dai tuoi piani di allenamento seguiti. Se desideri seguirlo di nuovo, puoi cliccare su \"Inizia di nuovo\" qui sotto.';

  @override
  String get startAgainText => 'Inizia di nuovo';

  @override
  String get unFollowTrainingPlanText => 'Non seguire il piano di allenamento';

  @override
  String get scheduleText => 'Programma';

  @override
  String get nothingToLoadText => 'Niente da caricare';

  @override
  String get minText => 'min';

  @override
  String get workoutOverviewText => 'Panoramica dell\'allenamento';

  @override
  String get workoutCompletedText => 'Allenamenti completati';

  @override
  String popupText(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'show': 'Mostra informazioni',
        'here': 'Vai qui',
        'other': 'non trovato',
      },
    );
    return '$_temp0';
  }

  @override
  String itemTypeInfo(String title) {
    String _temp0 = intl.Intl.selectLogic(
      title,
      {
        'single': 'Gli esercizi possono essere combinati in più serie con metriche diverse ad esse collegate.',
        'circuit': 'Un circuito basato sul tempo è una combinazione di esercizi eseguiti con un intervallo di lavoro-riposo prescritto. Ogni round può avere un intervallo di lavoro-riposo e/o esercizi diversi.',
        'reps': 'Un circuito basato sulle ripetizioni è una combinazione di esercizi eseguiti con brevi periodi di riposo tra di essi per un numero prefissato di ripetizioni. Ogni round può avere un numero diverso di ripetizioni, intervallo di riposo e/o esercizi.',
        'ss': 'Il concetto di superset consiste nel eseguire 2 esercizi di seguito, seguiti da un breve riposo (ma non sempre).',
        'rft': 'RFT è l\'abbreviazione di \'rounds for time\'. I partecipanti devono completare il numero prefissato di round e ripetizioni il prima possibile. Un round è una sequenza di tutti gli esercizi. Il tempo impiegato dai partecipanti per completare il numero prefissato di round è il loro punteggio.',
        'amrap': 'AMRAP è l\'abbreviazione di \'as many reps as possible\'. I partecipanti devono completare il maggior numero di ripetizioni possibile della sequenza di esercizi data in un determinato periodo di tempo. Il numero totale di ripetizioni completate è il punteggio del partecipante.',
        'enom': 'EMOM è l\'abbreviazione di \'every minute on the minute\'. In questo tipo di allenamento, il partecipante deve completare gli esercizi all\'inizio di ogni minuto per un numero prefissato di minuti. Ogni minuto può avere esercizi diversi con valori diversi.',
        'other': 'non trovato',
      },
    );
    return '$_temp0';
  }
}
