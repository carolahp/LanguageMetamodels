Class {
	#name : #ObjVLispMinLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> languageModelClass [
	^ ObjVLispMinLanguage
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMExecuteCreateAndAccessDictionary [
	entryPointCode := '| dict |
	dict := Dictionary new.
	dict at: #a put: #hola.
	dict at: #b put: #chao.
	System log: (dict at: #a) asString. 
	System quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMExecutePrintClassName [
	entryPointCode := 'System log: Point name asString. System quit'.
	expectedResult := 'Point'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMExecutePrintHola [
	entryPointCode := 'System log: ''hola'' asString. System quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMExecutePrintThisContext [
	entryPointCode := 'System log: thisContext asString. System quit'.
	expectedResult := '*nil* UndefinedObject(UndefinedObject) >>> entryPoint'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
