Class {
	#name : #MatchCVLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
MatchCVLanguageTest >> languageModelClass [
	^ MatchCVLanguage 
]

{ #category : #'instance creation' }
MatchCVLanguageTest >> sourcesPath [
	" same as objvlispMin "
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
MatchCVLanguageTest >> testInVMCreateAndAccessDictionary [
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
MatchCVLanguageTest >> testInVMExecuteReadClassVar [
	entryPointCode := '
	System log: Dog new kingdom asString. 
	System quit'.
	expectedResult := 'animal'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchCVLanguageTest >> testInVMExecuteReadClassVarFromClassSide [
	entryPointCode := '
	System log: Dog kingdom asString. 
	System quit'.
	expectedResult := 'animal'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchCVLanguageTest >> testInVMExecuteWriteClassVar [
	entryPointCode := '
	Dog new kingdom: #vegetal.
	System log: Dog new kingdom asString. 
	System quit'.
	expectedResult := 'vegetal'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
MatchCVLanguageTest >> testInVMExecuteWriteClassVarFromClassSide [
	entryPointCode := '
	Dog kingdom: #vegetal.
	System log: Dog kingdom asString. 
	System quit'.
	expectedResult := 'vegetal'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
