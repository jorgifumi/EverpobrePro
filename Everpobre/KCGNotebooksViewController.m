//
//  KCGNotebooksViewController.m
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 18/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "KCGNotebooksViewController.h"
#import "KCGNotebook.h"
#import "KCGNote.h"
#import "KCGNotesTableViewController.h"
#import "JLPNotesCollectionViewController.h"

@interface KCGNotebooksViewController ()

@end

@implementation KCGNotebooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Everpobre++";
    
    // Creamos botón de barra de +
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNotebook:)];
    
    // Lo añadimos
    self.navigationItem.rightBarButtonItem = btn;
    
    // Ponemos el botón de edición
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void) addNewNotebook:(id) sender {
    
    [KCGNotebook notebookWithName:@"New Notebook"
                          context:self.fetchedResultsController.managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Averiguar de que libreta nos esta hablando
        KCGNotebook *del = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        //Quitarla del modelo
        [self.fetchedResultsController.managedObjectContext deleteObject:del];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"NotebookCell";
    
    // Averiguar qué libreta es
    KCGNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Crear la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        // Creamos la elda de la nada
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
    }
    
    // Sincronizar libreta -> celda
    cell.textLabel.text = nb.name;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [fmt stringFromDate:nb.modificationDate];
    
    
    // Devolvemos la celda
    return cell;
}


#pragma mark - Navigation

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener la libreta
    KCGNotebook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Crear el fetch request
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:[KCGNote entityName]];
    
    // Configurarlo con un predicado
    r.fetchBatchSize = 25;
    r.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:KCGNoteAttributes.name
                                                        ascending:YES
                                                         selector:@selector(caseInsensitiveCompare:)],
                          [NSSortDescriptor sortDescriptorWithKey:KCGNoteAttributes.modificationDate
                                                        ascending:NO]];
    
    r.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", nb];
    
    
    // Crear el fetchedResults
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:r
                                                                         managedObjectContext:nb.managedObjectContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
    
    // Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 150);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    // Crear el controlador
//    KCGNotesTableViewController *nVC = [[KCGNotesTableViewController alloc] initWithFetchedResultsController:fc
//                                                                                                       style:UITableViewStylePlain
//                                                                                                    notebook:nb];
    JLPNotesCollectionViewController *nVC = [JLPNotesCollectionViewController coreDataCollectionViewControllerWithFetchedResultsController:fc
                                                                                                                                     layout:layout];

    // Assign notebook property
    nVC.notebook = nb;
    
    // Pushearlo
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}


@end
