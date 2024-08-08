#import <Foundation/Foundation.h>
#import "EasyPermissionSetting.h"


typedef NS_ENUM(NSInteger,EasyPermissionType)
{
    EasyPermissionType_Location,
    EasyPermissionType_Camera,
    EasyPermissionType_Photos,
    EasyPermissionType_Contacts,
    EasyPermissionType_Reminders,
    EasyPermissionType_Calendar,
    EasyPermissionType_Microphone,
    EasyPermissionType_Health,
    EasyPermissionType_DataNetwork,
    EasyPermissionType_MediaLibrary,
    EasyPermissionType_Tracking,
    EasyPermissionType_Notification,
    EasyPermissionType_Bluetooth
};

@interface EasyPermission : NSObject

/**
 only effective for location servince,other type reture YES


 @param type permission type,when type is not location,return YES
 @return YES if system location privacy service enabled NO othersize
 */
+ (BOOL)isServicesEnabledWithType:(EasyPermissionType)type;


/**
 whether device support the type

 @param type permission type
 @return  YES if device support

 */
+ (BOOL)isDeviceSupportedWithType:(EasyPermissionType)type;

/**
 whether permission has been obtained, only return status, not request permission
 for example, u can use this method in app setting, show permission status
 in most cases, suggest call "authorizeWithType:completion" method

 @param type permission type
 @return YES if Permission has been obtained,NO othersize
 */
+ (BOOL)authorizedWithType:(EasyPermissionType)type;


/**
 request permission and return status in main thread by block.
 execute block immediately when permission has been requested,else request permission and waiting for user to choose "Don't allow" or "Allow"

 @param type permission type
 @param completion May be called immediately if permission has been requested
 granted: YES if permission has been obtained, firstTime: YES if first time to request permission
 */
+ (void)authorizeWithType:(EasyPermissionType)type completion:(void(^)(BOOL granted,BOOL firstTime))completion;





@end
