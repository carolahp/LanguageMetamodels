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
ObjVLispNSLanguageTest >> testInModelAccessClassWithRole [
	
	entryPointCode := ''.
	model := self newModel.
	self assert: (model classNamed: #Array) role name equals: #Array.
	self assert: (model classNamed: #SmallInteger) role name equals: #SmallInteger.
	self assert: (model classNamed: #SmallInteger) layout class equals: EP2ImmediateLayout.
	model generate.
	self assert: (model classNamed: #SmallInteger) remote layout class equals: EP2ImmediateLayout.
	
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testInVMAccessKernelPackage [
	
	entryPointCode := 'System log: System asString.
	System quit'.
	expectedResult := 'System'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testInVMAccessPrivatePackage [
	
	entryPointCode := '| dog sys |
sys := (Kernel>#System).
dog := (Animals>#Dog) new.
dog logPackage.
sys quit'.
	expectedResult := 'Kernel
PCArray
Application
App2'.
self newModel.
model generate.
model spurImage.
self halt.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testModelDefinesClassDogInPackageApplication [
	
	entryPointCode := ''.
	model := self newModel.
	self assert: (model classNamed: #'Animals>Dog') package name equals: #Animals.
	self assert: (model classNamed: #'Pets>Dog') package name equals: #Pets
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testModelDefinesKernelClassesInPackageKernel [
	
	entryPointCode := ''.
	model := self newModel.
	self assert: (model classNamed: #Class) package name equals: #Kernel.
	self assert: (model classNamed: #Object) package name equals: #Kernel.
	self assert: (model classNamed: #Array) package name equals: #Kernel.
	
]
