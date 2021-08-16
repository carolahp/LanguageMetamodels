Class {
	#name : #ObjVLispDynLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
ObjVLispDynLanguageTest >> languageModelClass [
	^ ObjVLispDynLanguage 
]

{ #category : #'instance creation' }
ObjVLispDynLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
ObjVLispDynLanguageTest >> testInVMExecuteDynamicVarTest [
	"This won't work because EP2SemanticAnalyzer>>declareVariableNode: is not creating instances of VariableModel"
	entryPointCode := 'System log: ''Processor: '', Processor asString. 
	DynamicTest new test.
	System quit.'.
	expectedResult := 'nil'.
	self assert: (self inVMExecuteEntryPoint) equals: expectedResult
]
