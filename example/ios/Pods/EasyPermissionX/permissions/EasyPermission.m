#import "EasyPermission.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>


typedef void(^completionPermissionHandler)(BOOL granted,BOOL firstTime);


@implementation EasyPermission


+ (BOOL)isServicesEnabledWithType:(EasyPermissionType)type
{
    if (type == EasyPermissionType_Location)
    {
        SEL sel = NSSelectorFromString(@"isServicesEnabled");
        BOOL ret  = ((BOOL *(*)(id,SEL))objc_msgSend)( NSClassFromString(@"EasyPermissionLocation"), sel);

        return ret;
    }
    return YES;
}

+ (BOOL)isDeviceSupportedWithType:(EasyPermissionType)type
{
    if (type == EasyPermissionType_Health) {
        
        SEL sel = NSSelectorFromString(@"isHealthDataAvailable");
        BOOL ret  = ((BOOL *(*)(id,SEL))objc_msgSend)( NSClassFromString(@"EasyPermissionHealth"), sel);
        return ret;
    }
    return YES;
}

+ (BOOL)authorizedWithType:(EasyPermissionType)type
{
    SEL sel = NSSelectorFromString(@"authorized");
    
    NSString *strClass = nil;
    switch (type) {
        case EasyPermissionType_Location:
            strClass = @"EasyPermissionLocation";
            break;
        case EasyPermissionType_Camera:
            strClass = @"EasyPermissionCamera";
            break;
        case EasyPermissionType_Photos:
            strClass = @"EasyPermissionPhotos";
            break;
        case EasyPermissionType_Contacts:
            strClass = @"EasyPermissionContacts";
            break;
        case EasyPermissionType_Reminders:
            strClass = @"EasyPermissionReminders";
            break;
        case EasyPermissionType_Calendar:
            strClass = @"EasyPermissionCalendar";
            break;
        case EasyPermissionType_Microphone:
            strClass = @"EasyPermissionMicrophone";
            break;
        case EasyPermissionType_Health:
            strClass = @"EasyPermissionHealth";
            break;
        case EasyPermissionType_DataNetwork:
            break;
        case EasyPermissionType_MediaLibrary:
            strClass = @"EasyPermissionMediaLibrary";
            break;
        case EasyPermissionType_Tracking:
            strClass = @"EasyPermissionTracking";
            break;
        case EasyPermissionType_Notification:
            strClass = @"EasyPermissionNotification";
            break;
            
        default:
            break;
    }
    
    if (strClass) {
        BOOL ret  = ((BOOL *(*)(id,SEL))objc_msgSend)( NSClassFromString(strClass), sel);
        return ret;
    }
    
    return NO;
}

+ (void)authorizeWithType:(EasyPermissionType)type completion:(void(^)(BOOL granted,BOOL firstTime))completion
{
    NSString *strClass = nil;
    switch (type) {
        case EasyPermissionType_Location:
            strClass = @"EasyPermissionLocation";
            break;
        case EasyPermissionType_Camera:
            strClass = @"EasyPermissionCamera";
            break;
        case EasyPermissionType_Photos:
            strClass = @"EasyPermissionPhotos";
            break;
        case EasyPermissionType_Contacts:
            strClass = @"EasyPermissionContacts";
            break;
        case EasyPermissionType_Reminders:
            strClass = @"EasyPermissionReminders";
            break;
        case EasyPermissionType_Calendar:
             strClass = @"EasyPermissionCalendar";
            break;
        case EasyPermissionType_Microphone:
            strClass = @"EasyPermissionMicrophone";
            break;
        case EasyPermissionType_Health:
            strClass = @"EasyPermissionHealth";
            break;
        case EasyPermissionType_DataNetwork:
            strClass = @"EasyPermissionData";
            break;
        case EasyPermissionType_MediaLibrary:
            strClass = @"EasyPermissionMediaLibrary";
            break;
        case EasyPermissionType_Tracking:
            strClass = @"EasyPermissionTracking";
            break;
        case EasyPermissionType_Notification:
            strClass = @"EasyPermissionNotification";
            break;
        case EasyPermissionType_Bluetooth:
            strClass = @"EasyPermissionBluetooth";
            break;
            
        default:
            break;
    }
    
    if (strClass)
    {
        SEL sel = NSSelectorFromString(@"authorizeWithCompletion:");
        ((void(*)(id,SEL, completionPermissionHandler))objc_msgSend)(NSClassFromString(strClass),sel, completion);
    }
}

@end
