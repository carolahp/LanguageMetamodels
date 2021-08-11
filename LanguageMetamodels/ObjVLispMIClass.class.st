Class {
	#name : #ObjVLispMIClass,
	#superclass : #ObjVLispMinClass,
	#instVars : [
		'slots'
	],
	#category : #'LanguageMetamodels-ObjVLispMI'
}

{ #category : #install }
ObjVLispMIClass >> initialize [ 
	super initialize.
	slots := self slots
]
