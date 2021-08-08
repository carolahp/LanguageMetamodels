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
MatchLanguageTest >> sourcesPath [
	" same as objvlispMin "
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
MatchLanguageTest >> testInVMExecuteCreateAndAccessDictionary [
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
MatchLanguageTest >> testInVMExecuteOnePlusOne [
	entryPointCode := 'System log: (1+1) asString. System quit'.
	expectedResult := '2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchLanguageTest >> testNewModel [
	entryPointCode:= 'System quit'.
	self newModel.
]
