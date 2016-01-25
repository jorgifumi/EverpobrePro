//
//  KCGNoteViewController.m
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 21/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "KCGNoteViewController.h"
#import "KCGNote.h"
#import "KCGPhotoViewController.h"

@interface KCGNoteViewController ()
@property (weak, nonatomic) IBOutlet UILabel *creationDateView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

- (IBAction)displayPhoto:(id)sender;

@property (strong, nonatomic) KCGNote *model;

@property (nonatomic) CGRect oldFrame;
@property (nonatomic) double animationDuration;
@property (nonatomic) BOOL isKeybordVisible;

@end

@implementation KCGNoteViewController

#pragma mark - Initialization

-(id) initWithModel: (KCGNote *) model{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    
    return self;
}

#pragma mark - Life cycle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Sincronizamos modelo -> vistas
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDte];
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
    
    // Alta en notificaciones del tecldo
    [self startObservingKeyboard];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizamos vistas -> modelo
    self.model.text = self.textView.text;
    self.model.name = self.nameView.text;
    
    // Baja de notificaciones del teclado
    [self stopObservingKeyboard];
}

#pragma mark - Notifications

- (void)startObservingKeyboard{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(keyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
}

- (void)stopObservingKeyboard{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(keyboardWillDissappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
}

- (void)keyboardWillAppear:(NSNotification *)note{

    if (!self.isKeybordVisible) {
        
        self.isKeybordVisible = YES;
        NSDictionary *info = note.userInfo;
        
        self.animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        CGRect oldFrame = self.textView.frame;
        
        CGRect kbdFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGRect newFrame = CGRectMake(oldFrame.origin.x,
                                     oldFrame.origin.y,
                                     oldFrame.size.width,
                                     oldFrame.size.height - kbdFrame.size.height + self.bottomToolbar.bounds.size.height);
        
        [UIView animateWithDuration:self.animationDuration
                         animations:^{
                             self.textView.frame = newFrame;
                         }];
        }
    }

- (void)keyboardWillDissappear:(NSNotification *)note{
   
    NSDictionary *info = note.userInfo;
    
    CGRect oldFrame = self.textView.frame;
    
    CGRect kbdFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGRect newFrame = CGRectMake(oldFrame.origin.x,
                                 oldFrame.origin.y,
                                 oldFrame.size.width,
                                 oldFrame.size.height + kbdFrame.size.height - self.bottomToolbar.bounds.size.height);

    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.textView.frame = newFrame;
                     }];
    
    self.isKeybordVisible = NO;
}

#pragma mark - Actions
- (IBAction)displayPhoto:(id)sender {
    
    KCGPhotoViewController *pVC = [[KCGPhotoViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:pVC
                                         animated:YES];
}

- (IBAction)removeKeyboard:(id)sender{

    [self.view endEditing:YES];
}

@end
