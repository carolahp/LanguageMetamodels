Class {
	#name : #CandleLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
CandleLanguageTest >> languageModelClass [
	^ CandleLanguage
]

{ #category : #'instance creation' }
CandleLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/gitrepos/PharoCandleLast/PharoCandleSrc'
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInInterpreterExecuteOnePlusOne [
	entryPointCode := ''.
	expectedResult := '2'.
	self assert: (self inInterpreterExecute: '(1+1) asString') equals: expectedResult
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInVMExecuteOnePlusOne [
	entryPointCode := 'PCSystem log: (1+1) asString. PCSystem quit'.
	expectedResult := '2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInVMExecutePrintHola [
	entryPointCode := 'PCSystem log: ''hola'' asString. PCSystem quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
