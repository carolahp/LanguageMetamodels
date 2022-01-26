Class {
	#name : #OwnerLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
OwnerLanguageTest >> gitBranchName [
	^ 'ownerlanguage'
]

{ #category : #'instance creation' }
OwnerLanguageTest >> gitRepoName [
	" Use candle sources "
	^ 'PharoCandleSrc'
]

{ #category : #'instance creation' }
OwnerLanguageTest >> languageModelClass [
	^ OwnerLanguage
]

{ #category : #'instance creation' }
OwnerLanguageTest >> testInVMInstantiationBenchmarks [
	entryPointCode := 'PCSystem log: PCSystem benchInstantiate asString.
	PCSystem quit.'.
	expectedResult := '100000 instances created'.
	self assert: (self inVMExecuteEntryPoint beginsWith: expectedResult) 
]

{ #category : #'instance creation' }
OwnerLanguageTest >> testInVMSystemDictionary [
	entryPointCode := 'PCSystem log: (Smalltalk globals at: #PCArray) name asString.
	PCSystem quit.'.
	expectedResult := 'PCArray'.
	self assert: (self inVMExecuteEntryPoint beginsWith: expectedResult) 
]
