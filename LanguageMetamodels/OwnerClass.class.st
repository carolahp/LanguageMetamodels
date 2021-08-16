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
	super installCustom.
	"dictionary := self objectSpace newRemoteDictionaryOfSize: 2."
	self remote instancesDict: self instancesDict.
	self test.
	self parent myRemoteSystemDictionary 
		at: self name asSymbol
		put: self remote
]

{ #category : #install }
OwnerClass >> instancesDict [
	^ self newInstruction
		code: 'InstancesDictionary new: 100';
		temps: #();
		evaluate.
	
]
