//
//  ContactsController.m
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 29/07/22.
//

#import "ContactsController.h"
#import "Entities/Category.h"
#import "AFNetworking.h"
#import "AgregarCategoriasController.h"

@interface ContactsController ()

@end

@implementation ContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Categories = [[NSMutableArray alloc] init];
    
    [self CargarDatos];
}

- (IBAction)onDelete:(id)sender {
    @try {
        
        NSInteger row = [_tabla selectedRow];
        
        if(row != -1){
            Category * selectedCategory = [_Categories objectAtIndex:row];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            
            AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            
            [self InicializarProgress];
            
            [manager DELETE: [NSString stringWithFormat:@"http://apiestudiosalle2.azurewebsites.net/v1/Categories/DeleteCategory/%@", selectedCategory.categoryID]
              parameters:nil
                 headers:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self mensaje:[NSString stringWithFormat:@"%@", responseObject] yCuerpoMensaje:@"Proceso"];
                [self FinalizarProgress];
                
                [self->_Categories removeObjectAtIndex:row];
                [self->_tabla reloadData];
                
        }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error %@" , error);
    }];
    }
    } @catch (NSException *exception) {
        NSLog(@"Error %@", exception.reason);
    } @finally {
        
    }
}

- (void) CargarDatos{
    [_Categories removeAllObjects];
    @try {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [self InicializarProgress];
        
        [manager GET: @"http://apiestudiosalle2.azurewebsites.net/v1/Categories/getAllCategories"
          parameters:nil
             headers:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self FinalizarProgress];
                 self -> datosJson = (NSDictionary *) responseObject;
            
            for (NSObject* key in self-> datosJson) {
                Category * category = [[Category alloc]init];
                
                [category setCategoryID:(NSString *)[key valueForKey:@"categoryID"]];
                [category setCategoryName:(NSString *)[key valueForKey:@"categoryName"]];
                [category setDescription:(NSString *)[key valueForKey:@"description"]];
                
                [self->_Categories addObject:category];
            }
            [NSThread sleepForTimeInterval:5.0f];
            [self->_tabla reloadData];
            
            [self FinalizarProgress];
        }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error %@" , error);
    }];
        
        
    } @catch (NSException *exception) {
        NSLog(@"Error %@", exception.reason);
    } @finally {
        
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return [_Categories count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    Category *p = [_Categories objectAtIndex:row];
    NSString* identifier = [tableColumn identifier];
    NSString* columna = [p valueForKey:identifier];
    
    return columna;
}

- (void) mensaje: (NSString *) titulo yCuerpoMensaje:(NSString *) mensaje {
    NSAlert *alerta = [[NSAlert alloc] init];
    [alerta addButtonWithTitle: @"Continuar"];
    [alerta setMessageText:titulo];
    [alerta setInformativeText:mensaje];
    [alerta setAlertStyle:NSAlertStyleInformational];
    [alerta runModal];
}

-(void) InicializarProgress{
    [_progressIndicator setHidden:NO];
    [_progressIndicator setIndeterminate:YES];
    [_progressIndicator setUsesThreadedAnimation:YES];
    [_progressIndicator startAnimation:nil];
}
-(void) FinalizarProgress{
    [_progressIndicator stopAnimation:nil];
    [_progressIndicator setHidden:YES];
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sende
{
    if([[segue identifier] isEqualToString:@"agregar"])
    {
        AgregarCategoriasController *agregar = [segue destinationController];
        agregar.esNuevo = YES;
        agregar.viewController = self;
    }
    else if([[segue identifier] isEqualToString:@"modificar"])
    {
        @try {
            NSInteger row = [_tabla selectedRow];
            
            if(row != -1)
            {
                Category *category = [_Categories objectAtIndex:row];
                AgregarCategoriasController *agregar = [segue destinationController];
                agregar.esNuevo = NO;
                agregar.viewController = self;
                agregar.category = category;
            }
            else
            {
                [self mensaje:@"Selecciona una fila" yCuerpoMensaje:@"Tablas"];
                return;
            }
            
        } @catch (NSException *exception) {
            [self mensaje:@"Error" yCuerpoMensaje:exception.reason];
        } @finally {
            //
        }
    }
}
@end
