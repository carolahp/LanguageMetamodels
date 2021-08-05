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
	self shouldBeImplemented.
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
	| mcDef mcDefNew superclassName className |
	
	mcDef := anEP2MCClassDefinition.
	className := self parent classOrMetaclassNameFrom: mcDef className. 
	self haltIf: [ className =  'ByteString'].
	self assert: (self parent isValidMetaclassName: className).
	superclassName := (mcDef superclassName = #nil)
		ifTrue: [ self halt. ]
		ifFalse: [ self parent classOrMetaclassNameFrom: mcDef superclassName ].
	mcDefNew := EP2MCClassDefinition
		name: className 
		superclassName: superclassName
		category: mcDef category
		instVarNames: #()
		comment: ''.
	self extendWithMonticello: mcDefNew.
	self soleInstance: (self parent classNamed: className).
	^ self
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	self package: aCandleClass package.
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
	self soleInstance isCandleClass.
	self parent isValidMetaclassName: self name.
	self allSuperclasses includes: self parent classClass
]
