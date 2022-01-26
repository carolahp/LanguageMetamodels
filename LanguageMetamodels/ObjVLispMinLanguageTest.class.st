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
ObjVLispMinLanguageTest >> testInUndeclaredGlobal [
	entryPointCode := 'System1'.
	self should: [ self inVMExecuteEntryPoint ] raise: EP2UndeclaredBindingError
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInUndeclaredReadLiteral [
	entryPointCode := 'a + 1'.
	self should: [ self inVMExecuteEntryPoint ] raise: EP2UndeclaredBindingError
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInUndeclaredWriteLiteral [
	entryPointCode := 'a := 1'.
	self should: [ self inVMExecuteEntryPoint ] raise: EP2UndeclaredBindingError
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMCreateAndAccessDictionary [
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
ObjVLispMinLanguageTest >> testInVMPrintClassName [
	entryPointCode := 'System log: Point name asString. System quit'.
	expectedResult := 'Point'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMPrintHola [
	entryPointCode := 'System log: ''hola'' asString. System quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispMinLanguageTest >> testInVMPrintThisContext [
	entryPointCode := 'System log: thisContext asString. System quit'.
	expectedResult := '*nil* UndefinedObject(UndefinedObject) >>> entryPoint'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
