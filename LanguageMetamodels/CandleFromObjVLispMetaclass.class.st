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

{ #category : #initialization }
CandleFromObjVLispMetaclass >> defaultMetaclass [ 
	^ self parent classMetaclass
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> defaultSuperclass [
	
	^ self parent classProtoObject metaclass
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

{ #category : #initialization }
CandleFromObjVLispMetaclass >> metaclass [
	^ self parent classMetaclass
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> soleInstance [
	^ soleInstance
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]
