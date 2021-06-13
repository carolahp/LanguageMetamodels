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
		instVarNames: #(soleInstance)
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

{ #category : #testing }
CandleMetaclass >> isCandleMetaclass [
	^ true
]

{ #category : #accessing }
CandleMetaclass >> metaclass [ 
	self parent classNamed: self defaultMetaclassName
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
