//
//  Persona+CoreDataProperties.h
//  
//
//  Created by MTWDM_2022 on 15/07/22.
//
//

#import "Persona+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Persona (CoreDataProperties)

+ (NSFetchRequest<Persona *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *domicilio;
@property (nonatomic) int32_t edad;
@property (nullable, nonatomic, copy) NSString *estadoCivil;
@property (nullable, nonatomic, copy) NSString *nombre;

@end

NS_ASSUME_NONNULL_END
