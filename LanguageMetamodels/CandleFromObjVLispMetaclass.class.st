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
	
	^ (self parent classWithRole: #ProtoObject) metaclass
	"^ #'PCObject class'"
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	self setLayoutKeepingSlots: (EP2FixedLayout on: self).
	self package: aCandleClass package.
	^ self
		superclass:
			(aCandleClass superclass
				ifNil: [ self halt.self defaultSuperclass ]
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
