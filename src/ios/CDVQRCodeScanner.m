/********* CDVQRCodeScanner.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "QRCodeReaderViewController.h"

@interface CDVQRCodeScanner : CDVPlugin {
    // Member variables go here.
}

- (void)scan:(CDVInvokedUrlCommand*)command;
@end

@implementation CDVQRCodeScanner

- (void)scan:(CDVInvokedUrlCommand*)command
{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        NSArray *types = @[AVMetadataObjectTypeQRCode];
        QRCodeReaderViewController* reader = [QRCodeReaderViewController readerWithCancelButtonTitle:[command.arguments objectAtIndex:0] metadataObjectTypes:types];
        
        // Set the presentation style
        reader.modalPresentationStyle = UIModalPresentationFormSheet;

        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            
            NSLog(@"Completion with result: %@", resultAsString);
            NSMutableDictionary* resultDict = [[NSMutableDictionary alloc] init];
            if(resultAsString == nil){
                [resultDict setObject:[NSNumber numberWithInt:1] forKey:@"cancelled"];
            } else {
                [resultDict setObject:[NSNumber numberWithInt:0] forKey:@"cancelled"];
                [resultDict setObject:resultAsString forKey:@"text"];
            }
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                          messageAsDictionary:resultDict];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            
            [self.viewController dismissViewControllerAnimated:YES completion:NULL];
        }];
        
        [self.viewController presentViewController:reader animated:YES completion:NULL];
    }
    else {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
    
}

@end