//
//  KCGPhotoViewController.m
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 22/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "KCGPhotoViewController.h"
#import "KCGNote.h"
#import "KCGPhoto.h"

@interface KCGPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic) BOOL shouldSaveImageToModel;
@property (nonatomic, strong) KCGNote *model;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *applyFilterButton;

@end

@implementation KCGPhotoViewController

- (id) initWithModel:(KCGNote *) note{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = note;
        if (note.photo.imageData == nil) {
            _shouldSaveImageToModel = NO;
        }else{
            _shouldSaveImageToModel = YES;
        }
    }
    
    return self;
}

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = self.model.name;
    if (self.model.photo.imageData != nil) {
        self.photoView.image = self.model.photo.image;
        self.shouldSaveImageToModel = YES;
    }else{
        self.photoView.image = [UIImage imageNamed:@"no-image-available.png"];
        self.shouldSaveImageToModel = NO;
    }
    
    self.deleteButton.enabled = self.shouldSaveImageToModel;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.shouldSaveImageToModel) {
        self.model.photo.image = self.photoView.image;
    }
    
}

#pragma mark - Actions

- (IBAction)takePhoto:(id)sender {
    
    // Crear un ImagePicker
    UIImagePickerController *pVC = [[UIImagePickerController alloc] init];
    
    // Configurarlo
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Habemus cámara
        pVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        // Me conformo con el carrete
        pVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    //Hacerme su delegado
    pVC.delegate = self;
    
    //Mostrarlo
    [self presentViewController:pVC
                       animated:YES
                     completion:nil];
    
    
    // Actualizamos el estado de los botones
    self.deleteButton.enabled = YES;
    self.applyFilterButton.enabled = YES;
    
    
}

- (IBAction)applyFilter:(id)sender {
    
    
}

- (IBAction)delete:(id)sender {
    
    CGRect oldBounds = self.photoView.bounds;
    
    [UIView animateWithDuration:0.9
                     animations:^{
                         self.photoView.alpha = 0;
                         self.photoView.bounds = CGRectZero;
                         
                     } completion:^(BOOL finished) {
                         // La eliminamos del modelo
                         self.model.photo.image = nil;
                         //Eliminamos de la vista
                         self.photoView.image = [UIImage imageNamed:@"no-image-available.png"];
                         
                         // Actualizamos el estado de los botones
                         self.deleteButton.enabled = NO;
                         self.applyFilterButton.enabled = NO;
                         
                         // Dejamos todo como estaba
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldBounds;
                     }];
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // Extraer la foto del diccionario de info
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Asegurarnos que la imagen se guarda
    self.shouldSaveImageToModel = YES;

    // Lo metemos en el modelo
    self.model.photo.image = img;
    
    // Ocultamos el picker
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

@end
