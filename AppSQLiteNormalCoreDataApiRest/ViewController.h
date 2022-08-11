//
//  ViewController.h
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 08/07/22.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Persona+CoreDataClass.h"

@interface ViewController : NSViewController<NSTableViewDataSource,
NSTableViewDelegate, NSFetchedResultsControllerDelegate>
@property (strong) IBOutlet NSTextField *txtNombre;
@property (strong) IBOutlet NSTextField *txtEdad;
@property (strong) IBOutlet NSComboBox *cmbEstadoCivil;
@property (strong) IBOutlet NSTextField *txtDomicilio;
@property (strong) IBOutlet NSTableView *tabla;

- (IBAction)onEliminar:(id)sender;
- (IBAction)onActualizar:(id)sender;
- (IBAction)onGuardar:(id)sender;
- (void) cargarDatos;
- (void) mensaje: (NSString *) titulo yCuerpoMensaje:(NSString *) mensaje;



@end

