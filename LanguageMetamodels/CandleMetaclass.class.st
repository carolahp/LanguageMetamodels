Class {
	#name : #CandleMetaclass,
	#superclass : #ClassModel,
	#instVars : [
		'soleInstance'
	],
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #contants }
CandleMetaclass >> defaultMetaclassName [
	^ #PCMetaclass
]

{ #category : #contants }
CandleMetaclass >> defaultSuperclassName [
	^ #PCClass
]

{ #category : #hooks }
CandleMetaclass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	| mcDef mcDefNew superclassName |
	
	mcDef := anEP2MCClassDefinition.
	superclassName := (mcDef superclassName = #nil)
		ifTrue: [ self defaultSuperclassName ]
		ifFalse: [ mcDef superclassName , self parent metaclassSuffix ].
	mcDefNew := EP2MCClassDefinition
		name: mcDef className , self parent metaclassSuffix
		superclassName: superclassName
		category: mcDef category
		instVarNames: #()
		comment: ''.
	self extendWithMonticello: mcDefNew.
	self soleInstance: (self parent classNamed: mcDef className).
	^ self
]

{ #category : #initializing }
CandleMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	self setLayoutKeepingSlots: (EP2FixedLayout on: self).
	
	^ self
		superclass:
			(aCandleClass superclass
				ifNil: [ aCandleClass parent ensureClassNamed: self defaultSuperclassName ]
				ifNotNil: [ aCandleClass superclass metaclass ]);
		soleInstance: aCandleClass
]

{ #category : #hooks }
CandleMetaclass >> innerBindingOf: varName [ 
	^ soleInstance innerBindingOf: varName asSymbol
]

{ #category : #install }
CandleMetaclass >> installCustom [
	self remote
		soleInstance: self soleInstance remote
]

{ #category : #hooks }
CandleMetaclass >> installStubCustom [

	self deprecated: 'Use LanguageModel >> installMulticlassStubs:'.
	"first install the stub of my metaclass"
	self metaclass installStub.
	"instantiate my metaclass to create a stub of me"
	^ self metaclass newStubWithFormat: self format
]

{ #category : #testing }
CandleMetaclass >> isCandleClass [
	^ false
]

{ #category : #testing }
CandleMetaclass >> isCandleMetaclass [
	^ true
]

{ #category : #accessing }
CandleMetaclass >> metaclass [ 
	^ self parent classNamed: self defaultMetaclassName
]

{ #category : #accessing }
CandleMetaclass >> remote [
	self flag: 'I should cast the remote object accordingly to the language model class'.
	remote ifNil: [ ^nil ].
	^ remote isNilObject 
		ifTrue: [ remote asRemoteNil ]
		ifFalse: [ remote asRemoteMetaclass ]
]

{ #category : #accessing }
CandleMetaclass >> soleInstance [
	^ soleInstance
]

{ #category : #accessing }
CandleMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]

{ #category : #testing }
CandleMetaclass >> test [ 
	super test.
	self assert: (self parent isValidMetaclassName: self name).
	self assert: self soleInstance isNotNil.
	self assert: self soleInstance isCandleMetaclass not
	
]
