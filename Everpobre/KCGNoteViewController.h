//
//  KCGNoteViewController.h
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 21/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KCGNote;
@class KCGNotebook;

@interface KCGNoteViewController : UIViewController

- (id)initWithModel:(KCGNote *)model isNew:(BOOL)new;

- (id)initForNewNoteInNotebook:(KCGNotebook *)notebook;

@end
