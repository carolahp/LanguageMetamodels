Class {
	#name : #CandleFromObjVLispMetaclass,
	#superclass : #ClassModel,
	#instVars : [
		'soleInstance'
	],
	#category : #'LanguageMetamodels-CandleFromObjVLisp'
}

{ #category : #initialization }
CandleFromObjVLispMetaclass >> defaultSuperclassName [
	^ #Behavior
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> initializeWithSoleInstance: aCandleClass [ 
	self setLayoutKeepingSlots: (EP2FixedLayout on: self).
	self halt.
	^ self
		superclass:
			(aCandleClass superclass
				ifNil: [ aCandleClass parent ensureClassNamed: self defaultSuperclassName ]
				ifNotNil: [ aCandleClass superclass metaclass ]);
		soleInstance: aCandleClass
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> soleInstance [
	^ soleInstance
]

{ #category : #initialization }
CandleFromObjVLispMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]
