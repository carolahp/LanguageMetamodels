"
Candle with namespaces.
Packages define the scope of classes.

Classes can be accessed through their name only from classes in the same package.
e.g. Dog new 

To access a class in an external package, send the message #> to the package, next to the class name.
e.g. (Application>#Dog) new

As a consequence, you can have one or more classes sharing the same name, as long as they belong to different packages.
e.g. (App2>#Cat) and (Application>#Cat)

Try it with the next entry point 
| dog sys |
sys := (Kernel>#PCSystem).
dog := (Application>#Dog) new.
dog logPackage.
sys quit

--------------------------------------------------------------------------
candle destroy.
candle := CandleNSLanguage 
newFromModel: '/Users/carolina.hernandez/Documents/gitrepos/PharoCandleLast/PharoCandleWithPackages' asFileReference 
withName: 'CandleP'
withEntryPoint: '
| dog sys |
sys := (Kernel>#PCSystem).
dog := (Application>#Dog) new.
dog logPackage.
sys quit'.

candle generate.
candle writeImage.
candle imageInDisk executeInVM.
candle browse.

candle spurImage.
candle debugEntryPoint.
candle evaluateCode: 'Smalltalk classes'
"
Class {
	#name : #CandleNSLanguage,
	#superclass : #CandleLanguage,
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

{ #category : #'hooks-api' }
CandleNSLanguage class >> classModel [
	^ CandleNSClass
]

{ #category : #'accessing classes' }
CandleNSLanguage >> allClasses [
	^ self packages flatCollect: #definedBehaviors
]

{ #category : #'accessing classes' }
CandleNSLanguage >> bindingOf: aSymbol [
	(self globalVariableNamed: aSymbol)
		ifNil: [ (self packageNamed: aSymbol ifAbsent: [nil]) ifNil: [ ^ nil ] ].

	^ self newGlobalBindingFor: aSymbol
]

{ #category : #'accessing classes' }
CandleNSLanguage >> createInitialObjects [
	| classes |
	self packages do: [ :pkg | pkg install. pkg register ].
	classes := self allClasses
		select: [ :class | class isCandleClass and: [ class remote isNotNil ] ].
	classes do: [ :class | class initializeClassVars ].
	classes do: [ :class | class register ].
	self evaluateCode: '(Kernel>#PCFloat) initialize'
]

{ #category : #'accessing classes' }
CandleNSLanguage >> loadGlobalVariables [
	self globalVariables
		add:
			((self class globalModel named: #Smalltalk parent: self)
				role: #Smalltalk;
				initializationCode: [ :anEspellBackend | 
					"'PCSmalltalkImage basicNew'"
					| remoteSmalltalk |
					remoteSmalltalk := (self classNamed: #PCSmalltalkImage)	ensureRemote basicNew.
					remoteSmalltalk
						instanceVariableAtIndex: 1
						put:
							(Dictionary new
								asRemoteObjectInObjectSpace: anEspellBackend objectSpace).
					remoteSmalltalk
						instanceVariableAtIndex: 2
						put:
							(Dictionary new
								asRemoteObjectInObjectSpace: anEspellBackend objectSpace) ])
]

{ #category : #'accessing classes' }
CandleNSLanguage >> transform [
	| objclass newclass newmetaclass package |
	objclass := self classNamed: #PCObject.
	package := self packageNamed: 'Application'.

	newclass := self class classModel named: #Cat parent: self.
	newclass package: package.
	newclass layout: (EP2FixedLayout on: newclass).
	newclass superclass: objclass.

	newmetaclass := self class classModel named: #'Cat class' parent: self.
	newmetaclass package: package.
	newmetaclass layout: (EP2FixedLayout on: newmetaclass).
	newmetaclass soleInstance: newclass. 
	newmetaclass superclass: objclass metaclass.

	package addDefinedBehavior: newclass.
	package addDefinedBehavior: newmetaclass.

	^ self
]
