//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_easy_permission/FlutterEasyPermissionPlugin.h>)
#import <flutter_easy_permission/FlutterEasyPermissionPlugin.h>
#else
@import flutter_easy_permission;
#endif

#if __has_include(<flutter_scankit_plus/FlutterScankitPlusPlugin.h>)
#import <flutter_scankit_plus/FlutterScankitPlusPlugin.h>
#else
@import flutter_scankit_plus;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterEasyPermissionPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterEasyPermissionPlugin"]];
  [FlutterScankitPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterScankitPlusPlugin"]];
}

@end
