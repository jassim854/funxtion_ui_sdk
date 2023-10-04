//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_cached_video_player/CachedVideoPlayerPlugin.h>)
#import <flutter_cached_video_player/CachedVideoPlayerPlugin.h>
#else
@import flutter_cached_video_player;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [CachedVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"CachedVideoPlayerPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
}

@end
