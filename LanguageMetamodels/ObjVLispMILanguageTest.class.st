Class {
	#name : #ObjVLispMILanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> languageModelClass [
	^ ObjVLispMILanguage
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMGetPointSlots [
	entryPointCode := '
	System log: Point allSlots asString.
	System quit'.
	expectedResult := 'OrderedCollection (x => InstanceVariableSlot y => InstanceVariableSlot )'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiClassesMetaclassIsMulticlass [
	entryPointCode := '
	System log: PetMulti class name asString.
	System log: DogMulti class name asString.
	System quit'.
	expectedResult := 'Multiclass
Multiclass'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiobjectDefinesMLocalMethodReferencingInheritedSlot [
	entryPointCode := '| dog |
	dog := DogMulti new.
	dog name: #spike.
	System log: dog prettyPrintName asString.
	System quit'.
	expectedResult := '"spike"'.
	
	model := self newModel.
	(model classNamed: #DogMulti)
		addLocalMethodFromSource:
			'prettyPrintName
		^ ''"'', name, ''"'''
		selector: #prettyPrintName.
	model generate.
	
	self
		assert: model writeImage executeInVM
		equals: expectedResult
		
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiobjectDefinesMLocalMethodReferencingInheritedSlotFromExtraSuperclass [
	entryPointCode := '| dog |
	dog := DogMulti new.
	dog color: #red.
	System log: dog prettyPrintColor asString.
	System quit'.
	expectedResult := '"red"'.
	
	model := self newModel.
	(model classNamed: #DogMulti)
		addLocalMethodFromSource:
			'prettyPrintColor
		^ ''"'', color, ''"'''
		selector: #prettyPrintColor.
	model generate.
	self
		assert: model writeImage executeInVM
		equals: expectedResult
		
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiobjectDoesNotUnderstand [
	entryPointCode := '| dog |
	dog := DogMulti new.
	dog fakeMessage: #red.
	System quit'.
	expectedResult := 'multiobject does not understand message'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiobjectInheritsMethodFromExtraSuperclass [
	entryPointCode := '| dog |
	dog := DogMulti new.
	dog color: #red.
	dog name: #spike.
	dog address: #anAddress.
	
	System log: dog color asString.
	System log: dog name asString.
	System log: dog address asString.
	
	System quit'.
	expectedResult := 'red
spike
anAddress'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiobjectUndefinedSlot [
	entryPointCode := '| dog |
	dog := DogMulti new.
	dog undefinedInstVar: #hola.
	System quit'.
	expectedResult := EP2UndeclaredBindingError.
	
	model := self newModel.
	(model classNamed: #DogMulti)
		addLocalMethodFromSource:
			'undefinedInstVar: aValue
		^ undefinedInstVar := aValue'
		selector: #undefinedInstVar:.
	
	self
		should: [ model generate ]
		raise: expectedResult
		whoseDescriptionIncludes: 'undefinedInstVar'
		description: ''
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMMultiobjectsExtraSlotsDoNotOverrideEachOther [
	entryPointCode := '| dog animal |
	animal := AnimalMulti new.
	animal color: #blue.
	 
	dog := DogMulti new.
	dog color: #red.
	
	System log: dog color asString.
	System log: animal color asString.
	System quit'.
	expectedResult := 'red
blue'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMPrintContext [
	entryPointCode := '
	System log: thisContext asString. 
	System quit'.
	expectedResult := '*nil* UndefinedObject(UndefinedObject) >>> entryPoint'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMPrintMulticlassSlots [
	entryPointCode := '
	System log: DogMulti allSlots asString. 
	System quit'.
	expectedResult := 'OrderedCollection (address => InstanceVariableSlot )'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMReadEmptyInstVarsDictFromMulticlass [
	entryPointCode := '| dog |
	dog := DogMulti new.
	System log: dog instVarsDict asString.	
	System quit'.
	expectedResult := 'Dictionary ()'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMReadMulticlassSlotValue [
	entryPointCode := '
	System log: DogMulti new address asString. 
	System quit'.
	expectedResult := 'nil'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMReadSuperclassesFromMulticlassWithOneExtraSuperclass [
	entryPointCode := '
	System log: DogMulti superclass asString.	
	System log: (DogMulti superclasses at: 1) asString.	
	System quit'.
	expectedResult := 'PetMulti
AnimalMulti'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMWriteAPointSlotX [
	entryPointCode := '|p|
	p := Point new.
	p x: 1 y: 2.
	System log: p x asString.
	System log: p y asString.
	System quit'.
	expectedResult := '1
2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMWriteMulticlassInheritedSlotValue [
	entryPointCode := '| pet dog |
	pet := PetMulti new.
	dog := DogMulti new.
	dog name: #spike.
	pet name: #pepito.
	System log: pet name asString. 
	System log: dog name asString. 
	System quit'.
	expectedResult := 'pepito
spike'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMWriteMulticlassSlotValue [
	entryPointCode := '| pet |
	pet := PetMulti new.
	pet address: #petAddress.
	System log: pet address asString. 
	pet address: #petAddress2.
	System log: pet address asString.	
	pet name: #pepito.
	System log: pet name asString. 
	pet name: #juanito.
	System log: pet name asString.	
	System quit'.
	expectedResult := 'petAddress
petAddress2
pepito
juanito'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
