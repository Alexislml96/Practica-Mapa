//
//  OpenWeatherMapController.h
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 15/07/22.
//

#import <Cocoa/Cocoa.h>
#import <MapKit/MapKit.h>

@interface OpenWeatherMapController : NSViewController<NSTableViewDataSource,
NSTableViewDelegate, NSFetchedResultsControllerDelegate>

{
    NSDictionary *datosJson;
    NSMutableArray *lugares;
}
@property (weak) IBOutlet NSTextField *txtCiudad;
- (IBAction)onConsultar:(id)sender;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSTextField *txtContenido;
@property (weak) IBOutlet MKMapView *mapa;
@property (weak) IBOutlet NSTableView *tabla;

@end

