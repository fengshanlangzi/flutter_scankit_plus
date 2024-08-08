#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface EasyPermissionCamera : NSObject

+ (BOOL)authorized;

+ (AVAuthorizationStatus)authorizationStatus;

+ (void)authorizeWithCompletion:(void(^)(BOOL granted ,BOOL firstTime ))completion;

@end
