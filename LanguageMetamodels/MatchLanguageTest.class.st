Class {
	#name : #MatchLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
MatchLanguageTest >> languageModelClass [
	^ MatchLanguage 
]

{ #category : #'instance creation' }
MatchLanguageTest >> testInVMCreateAndAccessDictionary [
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
MatchLanguageTest >> testInVMGetClassInstVarsNames [
	entryPointCode := '
	System log: Point instVarsNames asString. 
	System quit'.
	expectedResult := '#(''x'' ''y'' )'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchLanguageTest >> testInVMOnePlusOne [
	entryPointCode := 'System log: (1+1) asString. System quit'.
	expectedResult := '2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchLanguageTest >> testInVMPrintClassName [
	entryPointCode := 
	'System log: Point name asString. 
	System quit'.
	expectedResult := 'Point'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchLanguageTest >> testNewModel [
	entryPointCode:= 'System quit'.
	self newModel.
]
