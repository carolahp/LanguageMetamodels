"
Candle like class with implicit metaclasses.

The variable #instancesDict is a dictionary containing all instances hash and their respective owner. 
Used only for certain classes whose instances do not support instance variables
"
Class {
	#name : #OwnerClass,
	#superclass : #CandleClass,
	#instVars : [
		'instancesDict'
	],
	#category : #'LanguageMetamodels-Owner'
}

{ #category : #install }
OwnerClass >> installCustom [
	| dictionary |
	super installCustom.
	"dictionary := self objectSpace newRemoteDictionaryOfSize: 2."
	dictionary := self newInstruction
		code: 'InstancesDictionary new: 100';
		temps: #();
		evaluate.
	self remote instancesDict: dictionary.
	self test.
	self parent myRemoteSystemDictionary 
		at: self name asSymbol
		put: self remote
]
