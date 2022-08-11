//
//  ContactsController.h
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 29/07/22.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactsController : NSViewController<NSTableViewDataSource>
{
    NSDictionary * datosJson;
}
@property (nonatomic, retain) NSMutableArray * Categories;

@property (strong) IBOutlet NSProgressIndicator *progressIndicator;
@property (strong) IBOutlet NSTableView *tabla;
- (IBAction)onDelete:(id)sender;
- (void) CargarDatos;
- (void) mensaje: (NSString *) titulo yCuerpoMensaje:(NSString *) mensaje;

@end

NS_ASSUME_NONNULL_END
