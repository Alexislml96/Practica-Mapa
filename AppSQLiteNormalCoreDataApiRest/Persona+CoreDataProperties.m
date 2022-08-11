//
//  Persona+CoreDataProperties.m
//  
//
//  Created by MTWDM_2022 on 15/07/22.
//
//

#import "Persona+CoreDataProperties.h"

@implementation Persona (CoreDataProperties)

+ (NSFetchRequest<Persona *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Persona"];
}

@dynamic domicilio;
@dynamic edad;
@dynamic estadoCivil;
@dynamic nombre;

@end
