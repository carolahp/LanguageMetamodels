Class {
	#name : #KernelQuitLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
KernelQuitLanguageTest >> languageModelClass [
	^ KernelQuitLanguage
]

{ #category : #'instance creation' }
KernelQuitLanguageTest >> testInVMExecuteQuit [
	"This won't work because EP2SemanticAnalyzer>>declareVariableNode: is not creating instances of VariableModel"
	entryPointCode := 'Metaclass quit'.
	expectedResult := ''.
	self assert: (self inVMExecuteEntryPoint) equals: expectedResult
]
