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
	
	entryPointCode := 
	'Test1Dyn new test.
	System quit.'.
	expectedResult := 'hola
hola
12
12
chao
chao'.
	self assert: (self inVMExecuteEntryPoint) equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispDynLanguageTest >> testInVMPrintCompiledMethod [
	"This won't work because EP2SemanticAnalyzer>>declareVariableNode: is not creating instances of VariableModel"
	entryPointCode := 
	'System log: (DynTest1 methodDict at: #test) asString. 
	System quit.'.
	expectedResult := 'DynTest1>>test'.
	self assert: (self inVMExecuteEntryPoint) equals: expectedResult
]

{ #category : #'instance creation' }
ObjVLispDynLanguageTest >> testInVMPrintCompiledMethodLiterals [
	"This won't work because EP2SemanticAnalyzer>>declareVariableNode: is not creating instances of VariableModel"
	entryPointCode := 
	'System log: (Test1Dyn methodDict at: #test) allLiterals asString. 
	System quit.'.
	expectedResult := '#(#out #holahola)'.
	"self newModel.
	model generate.
	self halt.
	model spurImage."
	
	self assert: (self inVMExecuteEntryPoint) equals: expectedResult
]
