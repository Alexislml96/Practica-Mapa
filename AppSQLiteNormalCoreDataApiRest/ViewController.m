//
//  ViewController.m
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 08/07/22.
//

#import "ViewController.h"

@implementation ViewController
{
    Persona *persona;
    NSManagedObjectContext *context; // Almacena el contexto de core data;
    NSFetchedResultsController *fetchedResultsController;
    NSArray *personas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    context = ((AppDelegate *) [[NSApplication sharedApplication] delegate]).persistentContainer.viewContext;
    
    [self cargarDatos];
    
    
}


#pragma mark - Metodos Personalizados

- (void) cargarDatos {
    
    personas = nil;
    fetchedResultsController = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Persona" ];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if ([fetchedResultsController performFetch:&error]) {
        personas = fetchedResultsController.fetchedObjects;
    } else {
        NSLog(@"Sucedio un error %@", [error localizedDescription]);
    }
    
}
- (void) mensaje: (NSString *) titulo yCuerpoMensaje:(NSString *) mensaje {
    NSAlert *alerta = [[NSAlert alloc] init];
    [alerta addButtonWithTitle: @"Continuar"];
    [alerta setMessageText:titulo];
    [alerta setInformativeText:mensaje];
    [alerta setAlertStyle:NSAlertStyleInformational];
    [alerta runModal];
}




#pragma mark - NSTableViewDataSource


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [personas count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    Persona *p = [personas objectAtIndex:row];
    NSString *valor = (NSString *) [p valueForKey:tableColumn.identifier];
    return valor;
}

#pragma mark - NSTableViewDelegate

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if ([_tabla selectedRow] != -1) {
        NSTableView *tableView = notification.object;
        Persona *personaSelect = [personas objectAtIndex: [tableView selectedRow]];
        persona = personaSelect;
        
        [_txtNombre setStringValue:persona.nombre];
        [_txtEdad setStringValue: [NSString stringWithFormat: @"%d", persona.edad]];
        [_txtDomicilio setStringValue:persona.domicilio];
        [_cmbEstadoCivil setStringValue:persona.estadoCivil];

        
    } else {
        NSLog(@"Error");
    }
}



#pragma mark - IBActions

- (IBAction)onGuardar:(id)sender {
    NSManagedObject *entidadPersona = [NSEntityDescription insertNewObjectForEntityForName:@"Persona" inManagedObjectContext:context];
    
    [entidadPersona setValue:[_txtNombre stringValue] forKeyPath:@"nombre"];
    [entidadPersona setValue:[_txtDomicilio stringValue] forKeyPath:@"domicilio"];
    [entidadPersona setValue:[NSNumber numberWithInteger:[_txtEdad integerValue]] forKeyPath:@"edad"];
    [entidadPersona setValue:[_cmbEstadoCivil stringValue] forKeyPath:@"estadoCivil"];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Sucedio un error %@", [error localizedDescription]);
    } else {
        [self mensaje:@"Guardar" yCuerpoMensaje:@"Se guardo correctamente el registro"];
        [_txtEdad setStringValue:@""];
        [_txtNombre setStringValue:@""];
        [_txtDomicilio setStringValue:@""];
        [_cmbEstadoCivil setStringValue:@""];
        [self cargarDatos];
        [_tabla reloadData];
    }
    
}

- (IBAction)onActualizar:(id)sender {
    persona.nombre = _txtNombre.stringValue;
    persona.edad = _txtEdad.intValue;
    persona.domicilio = _txtDomicilio.stringValue;
    persona.estadoCivil = _cmbEstadoCivil.stringValue;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Sucedio un error %@", [error localizedDescription]);
    } else {
        [self mensaje:@"    Actualizar" yCuerpoMensaje:@"Se actualizo correctamente el registro"];
        [_txtEdad setStringValue:@""];
        [_txtNombre setStringValue:@""];
        [_txtDomicilio setStringValue:@""];
        [_cmbEstadoCivil setStringValue:@""];
        [self cargarDatos];
        [_tabla reloadData];
    }
    
}

- (IBAction)onEliminar:(id)sender {
    @try {
        Persona *personaDelete = [personas objectAtIndex:[_tabla selectedRow]];
        [context deleteObject:personaDelete];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Sucedio un error %@", [error localizedDescription]);
        } else {
            [self mensaje:@"    Eliminar" yCuerpoMensaje:@"Se elimino correctamente el registro"];
            [_txtEdad setStringValue:@""];
            [_txtNombre setStringValue:@""];
            [_txtDomicilio setStringValue:@""];
            [_cmbEstadoCivil setStringValue:@""];
            [self cargarDatos];
            [_tabla reloadData];
            persona = nil;
        }
        
    } @catch (NSException *exception) {
        NSLog(@"Sucedio un error %@", [exception reason]);
    } @finally {
    }
}
@end
