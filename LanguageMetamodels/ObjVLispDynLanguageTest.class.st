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
ObjVLispDynLanguageTest >> testInVMAccessCompiledMethodDynamicVariables [
	"This won't work because EP2SemanticAnalyzer>>declareVariableNode: is not creating instances of VariableModel"
	entryPointCode := 
	' |var1 var2|
	var1 := (Test1Dyn methodDict at: #test) dynamicVariableNamed: #out.
	var2 := (Test1Dyn methodDict at: #test) dynamicVariableNamed: #holahola.
	System log: var1 name asString.
	System log: var1 index asString.
	System log: var2 name asString.
	System log: var2 index asString.
	System quit.'.
	expectedResult := 'out
1
holahola
2'.
	self assert: (self inVMExecuteEntryPoint) equals: expectedResult
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
