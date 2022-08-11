//
//  AgregarCategoriasController.h
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 05/08/22.
//

#import <Cocoa/Cocoa.h>
#import "Entities/Category.h"
#import "ContactsController.h"

@interface AgregarCategoriasController : NSViewController

@property (nonatomic, retain) ContactsController* viewController;
@property BOOL esNuevo;
@property (nonatomic, retain) Category* category;
@property (strong) IBOutlet NSTextField *txtCategoria;
@property (strong) IBOutlet NSTextField *txtDescripcion;
@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) IBOutlet NSTextField *lblInformacion;
@property (strong) IBOutlet NSButton *btnModificar;
@property (strong) IBOutlet NSButton *btnGuardar;
- (IBAction)onModificar:(id)sender;
- (IBAction)onGuardar:(id)sender;

@end
