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
	entryPointCode := '
	System log: Point allSlots asString. 
	System quit'.
	expectedResult := ''.
	self assert: (self inInterpreterExecute: 'Point allSlots asString') equals: ''
]

{ #category : #'instance creation' }
ObjVLispMILanguageTest >> testInVMExecuteCreateAndAccessDictionary [
	entryPointCode := '| dict |
	dict := Dictionary new.
	dict at: #a put: #hola.
	dict at: #b put: #chao.
	System log: (dict at: #a) asString. 
	System quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
