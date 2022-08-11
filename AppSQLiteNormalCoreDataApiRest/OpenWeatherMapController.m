//
//  OpenWeatherMapController.m
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 15/07/22.
//

#import "OpenWeatherMapController.h"
#import "AFNetworking.h"
#import "Lugares.h"

@interface OpenWeatherMapController ()

@end

@implementation OpenWeatherMapController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_progressIndicator setHidden:YES];
    
    lugares = [[NSMutableArray alloc] init];
    
}

- (IBAction)onConsultar:(id)sender {
    @try {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [self InicializarProgress];
        
        [manager GET:[[NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?q=%@&apikey=b0dbac6b44483fedc0e1a7e447508ebc", _txtCiudad.stringValue] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]
          parameters:nil
             headers:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self FinalizarProgress];
                 
                 [_txtContenido setStringValue: responseObject];
                 
                 datosJson = (NSDictionary *) responseObject;
                 
                 NSObject *key = [datosJson valueForKey:@"coord"];
                 
                 double latitud = [[key valueForKey:@"lat"] doubleValue];
                 double longitud = [[key valueForKey:@"lon"] doubleValue];
                 
                 
                 CLLocationCoordinate2D coordenada = CLLocationCoordinate2DMake(latitud, longitud);
                 MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordenada, 2000, 2000);
                 MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                 [annotation setTitle:[NSString stringWithFormat: @"Tu buscaste %@" , _txtCiudad.stringValue]];
                 [annotation setCoordinate:coordenada];
                 [self.mapa setRegion: region];
                 [self.mapa addAnnotation: annotation];
                 
            
        
                 
        }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error %@" , error);
    }];
        
        Lugares *objLugar = [[Lugares alloc] init];
        [objLugar setBusqueda: [_txtCiudad stringValue]];
        
        [lugares addObject:objLugar];
        [_tabla reloadData];
        
    } @catch (NSException *exception) {
        NSLog(@"Error %@", exception.reason);
    } @finally {
        
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [lugares count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    Lugares *objP = [lugares objectAtIndex:row];
    NSString * identifier = [tableColumn identifier];
    NSString * columna = [objP valueForKey: identifier];
    
    return columna;
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
@end
