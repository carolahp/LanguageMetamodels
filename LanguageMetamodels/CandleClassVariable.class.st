Class {
	#name : #CandleClassVariable,
	#superclass : #LiteralVariableModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #'accessing-api' }
CandleClassVariable >> asRemoteObjectInObjectSpace: anEP2ObjectSpace [ 
	^ (self key -> self value) asRemoteObjectInObjectSpace: anEP2ObjectSpace 
]

{ #category : #testing }
CandleClassVariable >> isGlobalVariable [
	^ false
]
