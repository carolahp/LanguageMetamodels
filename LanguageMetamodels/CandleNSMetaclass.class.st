Class {
	#name : #CandleNSMetaclass,
	#superclass : #CandleMetaclass,
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

{ #category : #hooks }
CandleNSMetaclass >> binding [
	^ self environment environment newGlobalBindingFor: self name asSymbol
]

{ #category : #hooks }
CandleNSMetaclass >> bindingOf: varName [
	^ soleInstance bindingOf: varName asSymbol
]

{ #category : #hooks }
CandleNSMetaclass >> environment [
	^ self soleInstance environment

]

{ #category : #hooks }
CandleNSMetaclass >> registerCustom [
	^ ((self parent globalVariableNamed: #Smalltalk) remote
		instanceVariableAtIndex: 2) asRemoteDictionary
		at: self name asSymbol
		put: self remote
]
