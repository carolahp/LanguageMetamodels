Class {
	#name : #OwnerMethod,
	#superclass : #MethodModel,
	#category : #'LanguageMetamodels-Owner'
}

{ #category : #marking }
OwnerMethod >> markAsAccessed [
	| currentContext |
	super markAsAccessed.
	currentContext := remote backend builder debuggerInterpreter
		interpreter currentContext.
	(#(70 71 79 148 160) includes: remote primitive)
		ifTrue: [ currentContext sender sender methodModel
				ifNotNil: [ :method | method propertyNamed: #sendsNew put: true ] ]
]
