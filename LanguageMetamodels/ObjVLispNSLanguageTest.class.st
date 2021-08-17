Class {
	#name : #ObjVLispNSLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> languageModelClass [
	^ ObjVLispNSLanguage 
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testInVMAccessPrivatePackage [
	
	entryPointCode := '| dog sys |
sys := (Kernel>#PCSystem).
dog := (Application>#Dog) new.
dog logPackage.
sys quit'.
	expectedResult := 'Kernel
PCArray
Application
App2'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testModelDefinesClassDogInPackageApplication [
	
	entryPointCode := ''.
	model := self newModel.
	self assert: (model classNamed: #'Animals>Dog') package name equals: #Animals
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testModelDefinesKernelClassesInPackageKernel [
	
	entryPointCode := ''.
	model := self newModel.
	self assert: (model classNamed: #Class) package name equals: #Kernel.
	self assert: (model classNamed: #Object) package name equals: #Kernel.
	self assert: (model classNamed: #Array) package name equals: #Kernel.
	
]
