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

{ #category : #'hooks-api' }
CandleNSLanguage class >> customFirstClassModels [
	^ {self metaclassModel . self packageModel}
]

{ #category : #'hooks-api' }
CandleNSLanguage class >> metaclassModel [
	^ CandleNSMetaclass
]

{ #category : #'hooks-api' }
CandleNSLanguage class >> packageModel [
	^ CandleNSPackage 
]

{ #category : #'accessing classes' }
CandleNSLanguage >> addClass: aMClass [
	self
		classNamed: aMClass name
		ifAbsent: [ self allClasses at: aMClass fullName put: aMClass ]
		ifPresent: [ :found | 
			aMClass = found
				ifFalse: [ self error: 'trying to replace existent behavior' ]
				ifTrue: [ found ] ]
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
CandleNSLanguage >> customClassRoles [
	
	^ {
	(#Array -> #'Kernel>PCArray').
	(#Association -> #'Kernel>PCAssociation').
	(#BlockClosure -> #'Kernel>PCBlock').
	(#ByteArray -> #'Kernel>PCByteArray').
	(#ByteString -> #'Kernel>PCString').
	(#ByteSymbol -> #'Kernel>PCSymbol').
	(#Character -> #'Kernel>PCCharacter').
	(#CompiledMethod -> #'Kernel>PCCompiledMethod').
	(#Context -> #'Kernel>PCMethodContext').
	(#Dictionary -> #'Kernel>PCDictionary').
	(#False -> #'Kernel>PCFalse').
	(#Float -> #'Kernel>PCFloat').
	(#LargeNegativeInteger -> #'Kernel>PCLargeNegativeInteger').
	(#LargePositiveInteger -> #'Kernel>PCLargePositiveInteger').
	(#Message -> #'Kernel>PCMessage').
	(#Class -> #'Kernel>PCClass').
	(#Metaclass -> #'Kernel>PCMetaclass').
	(#MethodDictionary -> #'Kernel>PCMethodDictionary').
	(#Point -> #'Kernel>PCPoint').
	(#Process -> #'Kernel>PCProcess').
	(#ProcessList -> #'Kernel>PCProcessList').
	(#ProcessorScheduler -> #'Kernel>PCProcessorScheduler').
	(#ProtoObject -> #'Kernel>PCObject').
	(#Semaphore -> #'Kernel>PCSemaphore').
	(#SmallInteger -> #'Kernel>PCSmallInteger').
	(#True -> #'Kernel>PCTrue').
	(#UndefinedObject -> #'Kernel>PCUndefinedObject')}
]

{ #category : #'accessing classes' }
CandleNSLanguage >> defaultPackageName [ 
	^ #Kernel
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
	objclass := self classProtoObject.
	package := self ensurePackageNamed: 'Application'.

	newclass := self newClassNamed: #Cat.
	newclass package: package.
	newclass layout: (EP2FixedLayout on: newclass).
	newclass superclass: objclass.
	
	newmetaclass := self newClassNamed: #'Cat class'.
	newmetaclass package: package.
	newmetaclass layout: (EP2FixedLayout on: newmetaclass).
	newmetaclass soleInstance: newclass. 
	newmetaclass superclass: objclass metaclass.
	
	package addDefinedBehavior: newclass.
	package addDefinedBehavior: newmetaclass.
	
	self addClass: newclass.
	self addClass: newmetaclass.
	^ self
]
