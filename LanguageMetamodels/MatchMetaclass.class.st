Class {
	#name : #MatchMetaclass,
	#superclass : #ClassModel,
	#instVars : [
		'soleInstance'
	],
	#category : #'LanguageMetamodels-Match'
}

{ #category : #'hooks-api' }
MatchMetaclass class >> role [
	^ #Metaclass
]

{ #category : #binding }
MatchMetaclass >> bindingOf: aString [ 
	^ self soleInstance bindingOf: aString
]

{ #category : #initialization }
MatchMetaclass >> defaultMetaclass [ 
	^ self parent classMetaclass
]

{ #category : #initialization }
MatchMetaclass >> defaultSuperclass [
	
	^ self parent classProtoObject metaclass
]

{ #category : #hooks }
MatchMetaclass >> extendWithMonticelloCustom: anEP2MCClassDefinition [ 
	"| mcDef soleInstanceName |
	
	mcDef := anEP2MCClassDefinition.
	soleInstanceName := self parent classNameFrom: mcDef className. 
	self assert: (self parent isValidMetaclassName: soleInstanceName) not.
	self initializeWithSoleInstance: (self parent ensureClassNamed: soleInstanceName)."
	^ self
]

{ #category : #initialization }
MatchMetaclass >> initializeCustom [
	self
		initializeWithSoleInstance:
			(self parent
				classNamed: (self name copyReplaceAll: self parent class metaclassSuffix with: ''))
]

{ #category : #initialization }
MatchMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	self
		superclass:
			(aCandleClass superclass
				ifNil: [ self parent classClass ]
				ifNotNil: [ aCandleClass superclass metaclass ]);
		soleInstance: aCandleClass;
		package: aCandleClass package
]

{ #category : #hooks }
MatchMetaclass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #install }
MatchMetaclass >> installCustom [
	super installCustom
]

{ #category : #testing }
MatchMetaclass >> isCandleClass [
	^ false
]

{ #category : #calyso }
MatchMetaclass >> isInstanceSide [ 
	^ false
]

{ #category : #initialization }
MatchMetaclass >> metaclass [
	^ self parent classMetaclass
]

{ #category : #hooks }
MatchMetaclass >> registerCustom [
	^ nil
]

{ #category : #initialization }
MatchMetaclass >> soleInstance [
	^ soleInstance
		ifNil: [ self initializeCustom.
			soleInstance ]
]

{ #category : #initialization }
MatchMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]

{ #category : #initialization }
MatchMetaclass >> test [
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
