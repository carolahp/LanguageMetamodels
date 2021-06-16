Class {
	#name : #CandleLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #'hooks-api' }
CandleLanguage class >> classMetaclass [
	^ CandleMetaclass
]

{ #category : #'hooks-api' }
CandleLanguage class >> globalVariableMetaclass [
	" return the subclass of GlobalModel used to represent globals in your language "
	^ CandleGlobal
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

{ #category : #util }
CandleLanguage >> addBehavior: aBeh [ 
	^ super addBehavior: aBeh.
]

{ #category : #util }
CandleLanguage >> classNameFrom: aMetaclassName [
	^ aMetaclassName
		copyFrom: 1
		to: aMetaclassName size - self metaclassSuffix size
]

{ #category : #hooks }
CandleLanguage >> createInitialObjects [
	(self allClasses select: [ :class | class remote isNotNil ])
		do: [ :class |
		 class isCandleClass 
			ifTrue: [ class initializeClassVars ] ].
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
	(#ByteString -> #PCByteString).
	(#ByteSymbol -> #PCByteSymbol).
	(#Character -> #PCCharacter).
	(#CompiledMethod -> #PCCompiledMethod).
	(#Context -> #PCContext).
	(#Dictionary -> #PCDictionary).
	(#False -> #PCFalse).
	(#Float -> #PCFloat).
	(#LargeNegativeInteger -> #PCLargeNegativeInteger).
	(#LargePositiveInteger -> #PCLargePositiveInteger).
	(#Message -> #PCMessage).
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

{ #category : #util }
CandleLanguage >> ensureClassNamed: aName [
	^ self
		classNamed: aName
		ifAbsent: [ | newBeh |
			newBeh := (self isValidMetaclassName: aName)
				ifTrue: [ CandleMetaclass named: aName parent: self ]
				ifFalse: [ CandleClass named: aName parent: self ].
			self addBehavior: newBeh.
			newBeh ]
]

{ #category : #util }
CandleLanguage >> isValidMetaclassName: aString [
	^ (aString endsWith: self metaclassSuffix)
		and: [ aString size > self metaclassSuffix size
				and: [ (aString occurrencesOf: Character space) = 1 ] ]
]

{ #category : #hooks }
CandleLanguage >> loadGlobalVariables [
		self globalVariables
		add:
			((self class globalVariableMetaclass named: #Smalltalk parent: self)
				role: #Smalltalk;
				initializationCode: 'PCSmalltalkImage basicNew')
]

{ #category : #constants }
CandleLanguage >> metaclassSuffix [
	^ self class metaclassSuffix
]

{ #category : #hooks }
CandleLanguage >> transform [
	^ self
]
