Class {
	#name : #CandleMetaclass,
	#superclass : #ClassModel,
	#instVars : [
		'soleInstance'
	],
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #'hooks-api' }
CandleMetaclass class >> role [ 
	^ #Metaclass
]

{ #category : #testing }
CandleMetaclass >> bindingOf: aSymbol [ 
	^ self instanceSide bindingOf: aSymbol
]

{ #category : #testing }
CandleMetaclass >> classIsMeta [
	"tonel compatibility"
	^ self isCandleMetaclass
]

{ #category : #contants }
CandleMetaclass >> defaultMetaclassName [
	^ #PCMetaclass
]

{ #category : #contants }
CandleMetaclass >> defaultSuperclassName [
	^ #'PCObject class'
]

{ #category : #hooks }
CandleMetaclass >> environment [ 
	^ self soleInstance environment
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
CandleMetaclass >> initializeCustom [
	self
		initializeWithSoleInstance:
			(self parent
				classNamed: (self name copyReplaceAll: self parent class metaclassSuffix with: ''))
]

{ #category : #initializing }
CandleMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	self setLayoutKeepingSlots: (EP2FixedLayout on: self).
	^ self
		superclass:
			(aCandleClass superclass
				ifNil: [ aCandleClass parent classClass ]
				ifNotNil: [ aCandleClass superclass metaclass ]);
		soleInstance: aCandleClass;
		package: aCandleClass package
]

{ #category : #hooks }
CandleMetaclass >> innerBindingOf: varName [ 
	^ soleInstance innerBindingOf: varName asSymbol
]

{ #category : #install }
CandleMetaclass >> installCustom [
	super installCustom
	"self remote
		soleInstance: self soleInstance remote"
]

{ #category : #accessing }
CandleMetaclass >> instanceSide [ 
	
	^ soleInstance
]

{ #category : #testing }
CandleMetaclass >> isCandleClass [
	^ false
]

{ #category : #testing }
CandleMetaclass >> isCandleMetaclass [
	^ true
]

{ #category : #testing }
CandleMetaclass >> isMeta [ 
	^ self isCandleMetaclass 
]

{ #category : #accessing }
CandleMetaclass >> metaclass [ 
	^ self parent classWithRole: #Metaclass
]

{ #category : #hooks }
CandleMetaclass >> registerCustom [
	" no system dictionary to register to"
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
		ifNil: [ self initializeCustom.
			soleInstance ]
]

{ #category : #accessing }
CandleMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]

{ #category : #testing }
CandleMetaclass >> test [ 
	super test.
	self assert: self soleInstance isNotNil.
	self assert: self soleInstance isCandleClass.
	self assert: (self parent isValidMetaclassName: self name).
	self assert: (self allSuperclasses includes: self parent classClass).
	self assert: self package = self soleInstance package.
	self
		assert:
			((self soleInstance isProtoObject
				and: [ self superclass = self parent classClass ])
				or: [ self soleInstance superclass metaclass = self superclass ])
]

{ #category : #accessing }
CandleMetaclass >> tonelInstanceSide [ 
	
	^ soleInstance 
]
