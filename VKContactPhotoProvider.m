#import "VKContactPhotoProvider.h"

@implementation VKContactPhotoProvider
  - (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
    NSString *from_id = [NSString stringWithFormat:@"%@", [notification applicationUserInfo][@"data"][@"from_id"]];
    NSString *profile_url = [NSString stringWithFormat:@"https://m.vk.com/id%@", from_id];
    NSURL *url = [NSURL URLWithString:profile_url];

    NSError *error = nil;
    NSString *html = [NSString stringWithContentsOfURL:url encoding: NSUTF8StringEncoding error:&error];

    if (error == nil) {
      NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<div .+profile_panel.+\\s.+<img src=\"(.+)\" class" options:0 error:&error];
      NSTextCheckingResult *result = [regex firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];

      if (error == nil){
        NSString *imageURLStr = [html substringWithRange: [result rangeAtIndex:1]];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:imageURLStr fromURL:imageURL];
      }
    }
    return nil;
  }
@end
