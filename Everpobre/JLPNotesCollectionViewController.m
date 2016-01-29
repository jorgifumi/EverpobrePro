//
//  JLPNotesCollectionViewController.m
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 26/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "JLPNotesCollectionViewController.h"
#import "KCGNote.h"
#import "KCGNotebook.h"
#import "JLPNoteCollectionViewCell.h"
#import "KCGPhoto.h"
#import "KCGNoteViewController.h"

static NSString *cellId = @"NoteCellId";

@interface JLPNotesCollectionViewController ()

@end

@implementation JLPNotesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Creamos botón de barra de +
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote:)];
    
    // Lo añadimos
    self.navigationItem.rightBarButtonItem = btn;
}

- (void) addNewNote:(id)sender {
    
    KCGNoteViewController *newNoteVC = [[KCGNoteViewController alloc] initForNewNoteInNotebook:self.notebook];
    [self.navigationController pushViewController:newNoteVC
                                         animated:YES];
}

#pragma mark - View Life Cylce

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self registerNib];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    self.title = @"Notas";
}

#pragma mark - Xib registration

- (void)registerNib{
    
    UINib *nib = [UINib nibWithNibName:@"JLPNoteCollectionViewCell"
                                bundle:nil];
    
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Get object
    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Get Cell
    JLPNoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                                forIndexPath:indexPath];
    
    // Configure Cell
    [cell observeNote:note];
    
    // Return cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // Obtener la nota
    KCGNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear el controlador
    KCGNoteViewController *nVC = [[KCGNoteViewController alloc] initWithModel:note];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}

@end
