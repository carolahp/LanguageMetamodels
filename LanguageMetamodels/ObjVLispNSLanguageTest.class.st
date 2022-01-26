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
ObjVLispNSLanguageTest >> testInVMAccessClassesInPackage [
	
	entryPointCode := 'System log: System name asString.
	System quit'.
	expectedResult := 'System'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testInVMAccessKernelPackage [
	
	entryPointCode := 'System log: System name asString.
	System quit'.
	expectedResult := 'System'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testInVMAccessPrivatePackage [
	
	entryPointCode := '| dog sys |
dog := (Pets>#Dog) new.
dog accessArrayClass.
sys := (Kernel>#System).
sys quit'.
	expectedResult := 'Array'.
	self assert: self inVMExecuteEntryPoint equals: expectedResult
	
]

{ #category : #'instance creation' }
ObjVLispNSLanguageTest >> testInVMCreateAndAccessDictionary [
	entryPointCode := '| dict |
	dict := Dictionary new.
	dict at: #a put: #hola.
	dict at: #b put: #chao.
	System log: (dict at: #a) asString. 
	System quit'.
	expectedResult := 'hola'.
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
