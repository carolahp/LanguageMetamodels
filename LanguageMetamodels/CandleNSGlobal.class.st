Class {
	#name : #CandleNSGlobal,
	#superclass : #CandleGlobal,
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

{ #category : #registering }
CandleNSGlobal >> registerCustom [
	^ ((self parent globalVariableNamed: #Smalltalk) remote
		instanceVariableAtIndex: 1) asRemoteDictionary
		at: self name asSymbol
		put: self remote
]
