//
//  AppDelegate.m
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 14/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "AppDelegate.h"
#import "KCGNotebook.h"
#import "AGTCoreDataStack.h"
#import "KCGNote.h"
#import "KCGNotebooksViewController.h"
#import "UIViewController+Navigation.h"
#import "Settings.h"

@interface AppDelegate ()
@property (strong, nonatomic) AGTCoreDataStack *model;
@end

@implementation AppDelegate

- (void)createDummyData {
    
    // Creo libretas
    KCGNotebook *nb = [KCGNotebook notebookWithName:@"Ex novias para el recuerdo"
                                            context:self.model.context];
    
    KCGNotebook *nbl = [KCGNotebook notebookWithName:@"Lugares raros donde he estado"
                                            context:self.model.context];

    
    [KCGNote noteWithName:@"Pampita"
                                    notebook:nb
                                     context:self.model.context];
    
    [KCGNote noteWithName:@"Camila Dávalos"
                                   notebook:nb
                                    context:self.model.context];
    
    [KCGNote noteWithName:@"Mariana Dávalos"
                                   notebook:nb
                                    context:self.model.context];
    
    [KCGNote noteWithName:@"Tatooine"
                 notebook:nbl
                  context:self.model.context];
    
    [KCGNote noteWithName:@"Parla"
                 notebook:nbl
                  context:self.model.context];
    
    // Buscar objetos
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[KCGNote entityName]];

    req.fetchBatchSize = 25;
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:KCGNoteAttributes.name
                                                          ascending:YES
                                                           selector:@selector(caseInsensitiveCompare:)]];
    
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", nb];
    
    [self.model executeFetchRequest:req
                         errorBlock:^(NSError *error) {
                             NSLog(@"La cagaste, Burt Lancaster!");
                         }];
    
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Inicializando el stack
    self.model = [AGTCoreDataStack coreDataStackWithModelName:@"Everpobre"];
    
    // Meto datos chorras
    if (ADD_DUMMY_DATA) {
        [self.model zapAllData];
        [self createDummyData];
    }
    
    // Arranca el autosave
    if (AUTO_SAVE) {
        [self autoSave];
    }
    
    // Creo la window y tal y cual
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // NSFetchRequest
    NSFetchRequest *r = [NSFetchRequest fetchRequestWithEntityName:[KCGNotebook entityName]];
    r.fetchBatchSize = 25;
    r.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:KCGNotebookAttributes.name
                                                        ascending:YES
                                                         selector:@selector(caseInsensitiveCompare:)],
                          [NSSortDescriptor sortDescriptorWithKey:KCGNotebookAttributes.modificationDate
                                                        ascending:NO]];
    
    // NSFetchedResultsController
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:r managedObjectContext:self.model.context sectionNameKeyPath:nil cacheName:nil];
    
    
    // El controlador de tabla
    KCGNotebooksViewController *tVC = [[KCGNotebooksViewController alloc] initWithFetchedResultsController:fc style:UITableViewStylePlain];
    
    self.window.rootViewController = [tVC wrappedInNavigation];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar en resignActive");
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar en enterBackground");
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"Adiós mundo cruel");
    
}

#pragma mark - AutoSave
-(void) autoSave{
    
    // Guardamos
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al autoguardar!!");
    }];
    
    NSLog(@"AutoSave");
    // Programamos la siguiente llamada
    [self performSelector:@selector(autoSave)
               withObject:nil
               afterDelay:AUTOSAVE_DELAY];
    
}



@end
