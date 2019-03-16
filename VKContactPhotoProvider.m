#import "VKContactPhotoProvider.h"

@implementation VKContactPhotoProvider
  - (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
    NSString *from_id = [notification.applicationUserInfo valueForKeyPath:@"data.from_id"];
    if (!from_id) return nil;

    NSString *imageURLStr = [NSString stringWithFormat:@"https://shortlook-vk.herokuapp.com/profile-picture/%@", from_id];
    NSURL *imageURL = [NSURL URLWithString:imageURLStr];

    return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:imageURLStr fromURL:imageURL];
  }
@end
