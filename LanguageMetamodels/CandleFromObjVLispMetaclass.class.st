Class {
	#name : #CandleFromObjVLispMetaclass,
	#superclass : #ClassModel,
	#instVars : [
		'soleInstance'
	],
	#category : #'LanguageMetamodels-CandleFromObjVLisp'
}

{ #category : #'hooks-api' }
CandleFromObjVLispMetaclass class >> role [
	^ #Metaclass
]

{ #category : #binding }
CandleFromObjVLispMetaclass >> bindingOf: aString [ 
	^ self soleInstance bindingOf: aString
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> defaultMetaclass [ 
	^ self parent classMetaclass
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> defaultSuperclass [
	
	^ self parent classProtoObject metaclass
]

{ #category : #hooks }
CandleFromObjVLispMetaclass >> extendWithMonticelloCustom: anEP2MCClassDefinition [ 
	"| mcDef soleInstanceName |
	
	mcDef := anEP2MCClassDefinition.
	soleInstanceName := self parent classNameFrom: mcDef className. 
	self assert: (self parent isValidMetaclassName: soleInstanceName) not.
	self initializeWithSoleInstance: (self parent ensureClassNamed: soleInstanceName)."
	^ self
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	^ self
		superclass:
			(aCandleClass superclass
				ifNil: [ self parent classClass ]
				ifNotNil: [ aCandleClass superclass metaclass ]);
		soleInstance: aCandleClass
]

{ #category : #hooks }
CandleFromObjVLispMetaclass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #install }
CandleFromObjVLispMetaclass >> installCustom [
	^ nil
]

{ #category : #testing }
CandleFromObjVLispMetaclass >> isCandleClass [
	^ false
]

{ #category : #calyso }
CandleFromObjVLispMetaclass >> isInstanceSide [ 
	^ false
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> metaclass [
	^ self parent classMetaclass
]

{ #category : #hooks }
CandleFromObjVLispMetaclass >> registerCustom [
	^ nil
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> soleInstance [
	^ soleInstance
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> test [
	super test.
	self assert: self soleInstance isNotNil.
	self assert: self soleInstance isCandleClass.
	self assert: (self parent isValidMetaclassName: self name).
	self assert: (self allSuperclasses includes: self parent classClass).
	self assert: self package = self soleInstance package
]
