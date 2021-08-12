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
ObjVLispMILanguageTest >> testInInterpreterGetPointSlots [
	entryPointCode := 'System quit'.
	expectedResult := 'OrderedCollection (x => InstanceVariableSlot y => InstanceVariableSlot )'.
	self assert: (self inInterpreterExecute: 'Point allSlots asString') equals: expectedResult
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
ObjVLispMILanguageTest >> testInVMReadMulticlassSlotValue [
	entryPointCode := '
	System log: DogMulti new address asString. 
	System quit'.
	expectedResult := 'nil'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMWriteMulticlassSlotValue [
	entryPointCode := '| dog |
	dog := DogMulti new.
	dog address: #dogAddress.
	System log: dog address asString. 
	dog address: #dogAddress2.
	System log: dog address asString.	
	System quit'.
	expectedResult := 'dogAddress
dogAddress2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
