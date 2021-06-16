Class {
	#name : #CandleClassVariable,
	#superclass : #LiteralVariableModel,
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #hooks }
CandleClassVariable >> accept: anEPASTInterpreter assign: anEP2Mirror inNode: aRBGlobalNode [ 
	^ self remote: anEP2Mirror
]

{ #category : #'accessing-api' }
CandleClassVariable >> asRemoteObjectInObjectSpace: anEP2ObjectSpace [ 
	^ (self key -> self value) asRemoteObjectInObjectSpace: anEP2ObjectSpace 
]

{ #category : #testing }
CandleClassVariable >> isGlobalVariable [
	^ false
]
