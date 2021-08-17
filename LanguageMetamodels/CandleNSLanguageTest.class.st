Class {
	#name : #CandleNSLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
CandleNSLanguageTest >> languageModelClass [
	^ CandleNSLanguage
]

{ #category : #'instance creation' }
CandleNSLanguageTest >> newImageInMemory [
	^ [ super newImageInMemory ]
		on: AssertionFailure
		do:
			[ :e | "I have classes with the same name (in different packages) but the bootstrapEnvironment is an identityDictionary saving classes with using their name as key. Fix!" e resumeUnchecked: nil ]
]

{ #category : #'instance creation' }
CandleNSLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/gitrepos/PharoCandleLast/PharoCandleWithPackages'
]

{ #category : #'instance creation' }
CandleNSLanguageTest >> testInVMAccessPrivatePackage [
	
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
CandleNSLanguageTest >> testModelDefinesClassDogInPackageApplication [
	
	entryPointCode := ''.
	model := self newModel.
	self assert: (model classNamed: #Dog) isCandleClass.
	self assert: (model classNamed: #Dog) package name equals: #Application.
	
]

{ #category : #'instance creation' }
CandleNSLanguageTest >> testModelDefinesClassesCatInDifferentPackages [
	| appPackage app2Package cat cat2 |
	
	entryPointCode := ''.
	model := self newModel.
	appPackage := model packageNamed: #Application.
	app2Package := model packageNamed: #App2.
	cat := (appPackage behaviorNamed: #Cat).
	cat2 := (app2Package behaviorNamed: #Cat).
	self assert: cat isCandleClass.
	self assert: cat package equals: appPackage.
	self assert: cat2 isCandleClass.
	self assert: cat2 package equals: app2Package.
	
]
