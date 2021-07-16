Class {
	#name : #CandleGlobal,
	#superclass : #GlobalModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #registering }
CandleGlobal >> registerCustom [
	^ ((self parent globalVariableNamed: #Smalltalk) remote
		instanceVariableAtIndex: 1) asRemoteDictionary
		at: self name asSymbol
		put: self remote
]
