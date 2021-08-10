Class {
	#name : #MatchCVClass,
	#superclass : #MatchClass,
	#instVars : [
		'classPool'
	],
	#category : #'LanguageMetamodels-Match'
}

{ #category : #binding }
MatchCVClass >> bindingOf: varName [
	| aSymbol |
	aSymbol := varName asSymbol.
	^ (self innerBindingOf: aSymbol)
		ifNil: [ self environment bindingOf: aSymbol ]
]

{ #category : #accessing }
MatchCVClass >> classPool [
	^ classPool
]

{ #category : #accessing }
MatchCVClass >> classPool: anObject [
	classPool := anObject
]

{ #category : #binding }
MatchCVClass >> initialize [
	super initialize.
	classPool := Dictionary new
]

{ #category : #binding }
MatchCVClass >> innerBindingOf: aSymbol [
	(self classPool bindingOf: aSymbol)
		ifNotNil: [ :binding | 
			^ binding
	 ].
	self superclass
		ifNotNil: [ :supercl | ^ supercl innerBindingOf: aSymbol ].
	^ nil
]

{ #category : #binding }
MatchCVClass >> installCustom [
	super installCustom.
	"self remote classPool: self classPool"
]
