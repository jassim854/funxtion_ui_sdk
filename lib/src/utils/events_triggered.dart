import 'package:ui_tool_kit/ui_tool_kit.dart';

class EveentTriggered {
  static Function()? app_open;

  static Function()? session_start;
  static Function(String, String)? screen_viewed;
  static Function(String, int)? video_class_searched;

  static Function(int, List<SelectedFilterModel>)? video_class_filtered;
  static Function(String, String, String)? video_class_player_open;
  static Function(String, String, String)? video_class_player_pause;
  static Function(String, String, String, String)? video_class_player_scrub;
  static Function(String, String, String, String)? video_class_player_skip;
  static Function(
    String,
    String,
    String,
  )? video_class_player_close;
  static Function(String, String)? video_class_cta_pressed;
  static Function(String, int)? workouts_searched;
  static Function(int, List<SelectedFilterModel>)? workouts_filtered;
  static Function(String)? workout_preview_expanded;
  static Function(String)? workout_preview_exercise_info;
  static Function(String, String, String?)? workout_started;
  static Function()? workout_player_skip;
  static Function()? workout_player_previous;
  static Function()? workout_player_pause;
  static Function(String, String, String)? workout_player_type_info;
  static Function(String, String, String, String)? workout_player_exercise_info;
  static Function(String, String, String, String)? workout_player_trainer_notes;
  static Function(String,String)? workout_player_overview;
  static Function(String, String, String, String)? workout_player_overview_navigate;
  static Function(String, String, String, String)? workout_cancelled;
  static Function()? workout_completed;
  static Function(String, int)? plan_searched;
  static Function(int, List<SelectedFilterModel>)? plan_filtered;
  static Function()? plan_followed;
  static Function()? plan_cancelled;
  static Function()? plan_completed;
  static Function(String, int)? audio_class_searched;
  static Function(int, List<SelectedFilterModel>)? audio_class_filtered;
  static Function()? audio_class_player_open;
  static Function()? audio_class_player_pause;
  static Function()? audio_class_player_scrub;
  static Function()? audio_class_player_skip;
  static Function()? audio_class_player_close;
  static Function()? search_term;
  static Function()? search_result_clicked;
}
