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
CandleNSLanguageTest >> testExecuteInVMAccessPrivatePackage [
	
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
