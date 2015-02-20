//
//  MJSCConcurrenceViewController.h
//  Concurrencia
//
//  Created by María Jesús Senosiain Caamiña on 20/02/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJSCConcurrenceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *protoView;
- (IBAction)syncDownload:(id)sender;
- (IBAction)asyncDownload:(id)sender;
- (IBAction)asyncProDown:(id)sender;

@end
