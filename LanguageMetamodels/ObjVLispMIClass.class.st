Class {
	#name : #ObjVLispMIClass,
	#superclass : #ObjVLispMinClass,
	#instVars : [
		'slots'
	],
	#category : #'LanguageMetamodels-ObjVLispMultipleInheritance'
}

{ #category : #metamodel }
ObjVLispMIClass class >> customFirstClassModels [
	^ { self instanceVariableSlotModel }
]

{ #category : #install }
ObjVLispMIClass >> initialize [ 
	super initialize.
	slots := self slots
]
