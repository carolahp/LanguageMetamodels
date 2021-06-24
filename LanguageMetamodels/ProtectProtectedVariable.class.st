Class {
	#name : #ProtectProtectedVariable,
	#superclass : #LiteralVariableModel,
	#category : #'LanguageMetamodels-Protect'
}

{ #category : #testing }
ProtectProtectedVariable >> isGlobalVariable [ 
	^ false
]
