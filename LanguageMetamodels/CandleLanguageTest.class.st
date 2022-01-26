Class {
	#name : #CandleLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'external repository' }
CandleLanguageTest >> gitRepoName [
	" Use candle sources. If you want to build Candle from ObjVLispMin sources see MatchLanguageTest "
	^ 'PharoCandleSrc'
]

{ #category : #'instance creation' }
CandleLanguageTest >> languageModelClass [
	^ CandleLanguage
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInInterpreterExecuteOnePlusOne [
	entryPointCode := ''.
	expectedResult := '2'.
	self assert: (self inInterpreterExecute: '(1+1) asString') equals: expectedResult
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInVMCreateAndAccessDictionary [
	entryPointCode := '| dict |
	dict := PCDictionary new.
	dict at: #a put: #hola.
	dict at: #b put: #chao.
	PCSystem log: (dict at: #a) asString. 
	PCSystem quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInVMOnePlusOne [
	entryPointCode := 'PCSystem log: (1+1) asString. PCSystem quit'.
	expectedResult := '2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]

{ #category : #'instance creation' }
CandleLanguageTest >> testInVMPrintHola [
	entryPointCode := 'PCSystem log: ''hola'' asString. PCSystem quit'.
	expectedResult := 'hola'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
]
