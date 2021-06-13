Class {
	#name : #CandleMetaclass,
	#superclass : #ClassModel,
	#instVars : [
		'soleInstance'
	],
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #accessing }
CandleMetaclass >> soleInstance [
	^ soleInstance
]

{ #category : #accessing }
CandleMetaclass >> soleInstance: anObject [
	soleInstance := anObject
]
