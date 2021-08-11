"
Download my Language Definitions from https://github.com/carolahp/PharoCandleSrc (master branch)
and set them in the constructor 
--------------------------------------------------------------------------
CandleLanguage 
	newFromModel: pathToDefinitions 
	withName: #Candle 
	withEntryPoint: 'PCSystem log: ''hello from Candle!''. PCSystem quit'.
--------------------------------------------------------------------------
Another example:	

candle destroy.
candle := CandleLanguage 
newFromModel: '/Users/carolina.hernandez/Documents/gitrepos/PharoCandleLast/PharoCandleSrc' asFileReference 
withName: 'Candle'
withEntryPoint: '
| dog sys |
sys := PCSystem.
sys log: ''hola desde Candle!''.
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
	#name : #CandleLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #'hooks-api' }
CandleLanguage class >> classModel [
	^ CandleClass
]

{ #category : #'hooks-api' }
CandleLanguage class >> classModelFor: aString [
	^ (aString endsWith: self metaclassSuffix)
		ifTrue: [ self metaclassModel ]
		ifFalse: [ self classModel ]
]

{ #category : #'hooks-api' }
CandleLanguage class >> classVariableModel [
	^ CandleClassVariable
]

{ #category : #'hooks-api' }
CandleLanguage class >> customModels [
	^ {CandleMetaclass}
]

{ #category : #'hooks-api' }
CandleLanguage class >> globalModel [
	" return the subclass of GlobalModel used to represent globals in your language "
	^ CandleGlobal
]

{ #category : #'hooks-api' }
CandleLanguage class >> metaclassModel [
	^ CandleMetaclass
]

{ #category : #constants }
CandleLanguage class >> metaclassSuffix [
	^ ' class'
]

{ #category : #constants }
CandleLanguage class >> newMetaclassFor: aCandleClass [
	| newMetaclass |
	self deprecated: 'Use LanguageModel ensureClassNamed: '.
	newMetaclass setLayoutKeepingSlots: (EP2FixedLayout on: newMetaclass).
	
	^ newMetaclass
		superclass:
			(aCandleClass superclass
				ifNil: [ aCandleClass parent ensureClassNamed: #PCClass ]
				ifNotNil: [ aCandleClass superclass metaclass ]);
		soleInstance: aCandleClass
]

{ #category : #'hooks-api' }
CandleLanguage class >> packageModel [
	^ CandleNSPackage 
]

{ #category : #'hooks-api' }
CandleLanguage class >> simpleClassModel [
	^ CandleClass
]

{ #category : #'tonel repository' }
CandleLanguage >> addMethodFromMonticelloDefinition: aMCMethodDefinition [
	| methodDef classDef mcDef className |
	mcDef := aMCMethodDefinition.
	className := self classNameFromMonticello: mcDef className.
	mcDef classIsMeta
		ifTrue: [ self
				assert: self metaclassSuffix isNotNil
				description:
					'Your language should define implicit metaclasses to load class side methods'.
			self assert: (self isValidMetaclassName: className) not.
			className := className , self metaclassSuffix ].
	classDef := self ensureClassNamed: className.
	methodDef := classDef ensureLocalMethodNamed: mcDef selector.
	methodDef extendWithMonticello: mcDef.
	^ methodDef
]

{ #category : #'access special class' }
CandleLanguage >> classMetaclass [
	^ self classNamed: #PCMetaclass
]

{ #category : #hooks }
CandleLanguage >> createInitialObjects [
	| classes |
	classes := self allClasses
		select: [ :class | class isCandleClass and: [ class remote isNotNil ] ].
	classes do: [ :class | class initializeClassVars ].
	self evaluateCode: 'PCFloat initialize'.
]

{ #category : #hooks }
CandleLanguage >> createRemoteSystemDictionary [
	^ nil
]

{ #category : #roles }
CandleLanguage >> customClassRoles [
	^ {
	(#Array -> #PCArray).
	(#Association -> #PCAssociation).
	"(#Bitmap -> #PCBitmap). not defined in candle"
	(#BlockClosure -> #PCBlock).
	(#ByteArray -> #PCByteArray).
	(#ByteString -> #PCString).
	(#ByteSymbol -> #PCSymbol).
	(#Character -> #PCCharacter).
	(#CompiledMethod -> #PCCompiledMethod).
	(#Context -> #PCMethodContext).
	(#Dictionary -> #PCDictionary).
	(#False -> #PCFalse).
	(#Float -> #PCFloat).
	(#LargeNegativeInteger -> #PCLargeNegativeInteger).
	(#LargePositiveInteger -> #PCLargePositiveInteger).
	(#Message -> #PCMessage).
	(#Class -> #PCClass).
	(#Metaclass -> #PCMetaclass).
	(#MethodDictionary -> #PCMethodDictionary).
	(#Point -> #PCPoint).
	(#Process -> #PCProcess).
	(#ProcessList -> #PCProcessList).
	(#ProcessorScheduler -> #PCProcessorScheduler).
	(#ProtoObject -> #PCObject).
	(#Semaphore -> #PCSemaphore).
	(#SmallInteger -> #PCSmallInteger).
	(#True -> #PCTrue).
	(#UndefinedObject -> #PCUndefinedObject)}
]

{ #category : #hooks }
CandleLanguage >> exportAsTonelRepository: aFileReference [
	(self packages select: [ :pkg | pkg isNotEmpty ])
		do: [ :aPackage | 
			| aSnapshot info aVersion |
			aSnapshot := aPackage asMCSnapshot.
			info := MCVersionInfo new.
			info instVarNamed: #name put: aPackage name , '-author'.
			aVersion := MCVersion
				package: (MCPackage new name: aPackage name)
				info: info
				snapshot: aSnapshot
				dependencies: #().
			EP2TonelWriter fileOut: aVersion on: aFileReference metamodel: self ]
]

{ #category : #hooks }
CandleLanguage >> firstMetaclasses [
	| metaclass |
	metaclass := self classMetaclass.
	^ { metaclass . metaclass metaclass }
]

{ #category : #util }
CandleLanguage >> fixCircularInheritance [
	self classProtoObject metaclass superclass: self classClass.
	
	"self allClasses
		do: [ :class | 
			class superclass = class
				ifTrue: [ self halt.class superclass: nil ].
			class metaclass superclass 
				ifNil: [ self halt. class metaclass superclass: self classClass ] ]"
]

{ #category : #hooks }
CandleLanguage >> initializeSpecialObjectsArray [
	^ nil
]

{ #category : #util }
CandleLanguage >> isValidMetaclassName: aString [
	^ (aString endsWith: self metaclassSuffix)
		and: [ aString size > self metaclassSuffix size
				and: [ (aString occurrencesOf: Character space) = 1 ] ]
]

{ #category : #util }
CandleLanguage >> loadClasses [
	super loadClasses.
	self fixCircularInheritance
]

{ #category : #hooks }
CandleLanguage >> loadGlobalVariables [
	self globalVariables
		add:
			((self class globalModel named: #Smalltalk parent: self)
				role: #Smalltalk;
				initializationCode: 'PCSmalltalkImage basicNew')
]

{ #category : #'class instantiating' }
CandleLanguage >> loadKernel [
	| object class metaclass objectClass |
	object := self basicNewClassWithRole: #ProtoObject.
	self addClass: object.
	class := self basicNewClassWithRole: #Class.
	self addClass: class.
	metaclass := self basicNewClassWithRole: #Metaclass.
	self addClass: metaclass.
	object superclass: nil.
	class superclass: object.
	metaclass superclass: object.
	objectClass := (self basicNewClassNamed: object name, self class metaclassSuffix)
		parent: self;
		yourself.
	objectClass superclass: class.
	self addClass: objectClass.
	metaclass initialize.
	object initialize.
	class initialize.
	objectClass initialize
]

{ #category : #constants }
CandleLanguage >> metaclassSuffix [
	^ self class metaclassSuffix
]

{ #category : #'instantiating variables' }
CandleLanguage >> newClassVariableNamed: aString parent: aCandleClass [
	^ self class classVariableModel
		named: aString
		parent: aCandleClass
]

{ #category : #hooks }
CandleLanguage >> test [ 
	| model metamodel modelVars metamodelVars modelVarsLast metamodelVarsLast |
	super test.
	
	model := self classNamed: 'PCClass'.
	metamodel := self class classModel.
	
	modelVars := model allInstVarNames.
	metamodelVars := self class classModel allModelInstVarNames.
	
	modelVarsLast := (modelVars
		copyFrom: 4
		to: modelVars size) asIdentitySet.
		
	metamodelVarsLast := (metamodelVars
		copyFrom: 4
		to: metamodelVars size) asIdentitySet.
	
	self
		assert: (modelVars beginsWith: (metamodelVars copyFrom: 1 to: 3))
		description:
			'The first 3 instance variables of "' , model name
				, '" must be ' , (metamodelVars copyFrom: 1 to: 3) asString.
	
	self
		assert: (metamodelVarsLast asSet difference: modelVarsLast asSet) isEmpty
		description:
			'The class ' , metamodel asString
				, ' must define the same instance variables as '
				, model name asString.
]

{ #category : #util }
CandleLanguage >> transform [ 
	| class object |
	class := (self classNamed: #PCClass).
	object := (self classWithRole: #ProtoObject).
	object metaclass superclass: class.
	^ self
]
