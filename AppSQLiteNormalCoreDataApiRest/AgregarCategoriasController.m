//
//  AgregarCategoriasController.m
//  AppSQLiteNormalCoreDataApiRest
//
//  Created by MTWDM_2022 on 05/08/22.
//

#import "AgregarCategoriasController.h"
#import "AFNetworking.h"

@interface AgregarCategoriasController ()
{
    NSString *idCategoria;
    ContactsController *view;
}
@end

@implementation AgregarCategoriasController

- (void)viewDidLoad {
    [super viewDidLoad];
    view = [[ContactsController alloc] init];
    view = _viewController;
    
    if(_category != nil)
    {
        if(_esNuevo == NO)
        {
            idCategoria = _category.categoryID;
            [_txtCategoria setStringValue: _category.categoryName];
            [_txtDescripcion setStringValue: _category.description ? _category.description : @""];
            _btnGuardar.enabled = NO;
        }
        else
        {
            _btnModificar.enabled = NO;
        }
    }
    else
    {
        _btnModificar.enabled = NO;
        [_progressIndicator setHidden:YES];
    }
}

- (IBAction)onGuardar:(id)sender {
    @try {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            
            AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            
            [self InicializarProgress];
        
        NSDictionary *parameters = @{
            @"CategoryID" : @"0",
            @"CategoryName" : _txtCategoria.stringValue,
            @"Description" : _txtDescripcion.stringValue
        };
            
            [manager POST: @"http://apiestudiosalle2.azurewebsites.net/v1/Categories/AddCategoryV1"
              parameters: parameters
                 headers:nil
                 progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [NSThread sleepForTimeInterval:5.0f];
                
                [self FinalizarProgress];
                
                [self ->_lblInformacion setStringValue:responseObject];
                [self ->view CargarDatos];
        }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error %@" , error);
    }];

    } @catch (NSException *exception) {
        NSLog(@"Error %@", exception.reason);
    } @finally {
        
    }
}

- (IBAction)onModificar:(id)sender {
    @try {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            
            AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            
            [self InicializarProgress];
        
        NSDictionary *parameters = @{
            @"CategoryID" : idCategoria,
            @"CategoryName" : _txtCategoria.stringValue,
            @"Description" : _txtDescripcion.stringValue
        };
            
            [manager PUT: @"http://apiestudiosalle2.azurewebsites.net/v1/Categories/UpdateCategory"
              parameters: parameters
                 headers:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [NSThread sleepForTimeInterval:5.0f];
                
                [self FinalizarProgress];
                
                [self ->_lblInformacion setStringValue:responseObject];
                [self ->view CargarDatos];
        }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error %@" , error);
    }];

    } @catch (NSException *exception) {
        NSLog(@"Error %@", exception.reason);
    } @finally {
        
    }
    
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
