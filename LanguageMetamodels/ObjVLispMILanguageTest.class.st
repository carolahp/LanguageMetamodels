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
