Class {
	#name : #OwnerGlobal,
	#superclass : #CandleGlobal,
	#category : #'LanguageMetamodels-Owner'
}

{ #category : #registering }
OwnerGlobal >> registerCustom [
	self parent myRemoteSystemDictionary at: self name asSymbol put: self remote
]
