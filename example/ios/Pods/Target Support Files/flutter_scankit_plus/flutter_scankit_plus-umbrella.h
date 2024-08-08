#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FLScanKitUtilities.h"
#import "FLScanKitView.h"
#import "FlutterScankitPlusPlugin.h"
#import "QueuingEventSink.h"

FOUNDATION_EXPORT double flutter_scankit_plusVersionNumber;
FOUNDATION_EXPORT const unsigned char flutter_scankit_plusVersionString[];

