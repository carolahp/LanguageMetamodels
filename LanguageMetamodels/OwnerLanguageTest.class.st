Class {
	#name : #OwnerLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
OwnerLanguageTest >> languageModelClass [
	^ OwnerLanguage
]

{ #category : #'instance creation' }
OwnerLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/gitrepos/PharoCandleLast/Owner'
]

{ #category : #'instance creation' }
OwnerLanguageTest >> testExecuteInVMInstantiationBenchmarks [
	entryPointCode := 'PCSystem log: PCSystem benchInstantiate.
PCSystem quit.'.
	expectedResult := '1000000 instances created'.
	self assert: (self inVMExecuteEntryPoint beginsWith: expectedResult) 
]
