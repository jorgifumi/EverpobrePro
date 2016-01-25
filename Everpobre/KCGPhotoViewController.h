//
//  KCGPhotoViewController.h
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 22/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

@import UIKit;

@class KCGNote;

@interface KCGPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (id) initWithModel:(KCGNote *) note;

@end
