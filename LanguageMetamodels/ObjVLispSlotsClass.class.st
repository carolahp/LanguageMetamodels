Class {
	#name : #ObjVLispSlotsClass,
	#superclass : #ObjVLispMinClass,
	#instVars : [
		'slots'
	],
	#category : #'LanguageMetamodels-ObjVLispSlots'
}

{ #category : #instanciation }
ObjVLispSlotsClass class >> customModels [
	^ { self instanceVariableSlotModel }
]

{ #category : #binding }
ObjVLispSlotsClass >> initialize [ 
	super initialize.
	slots := self slots
]
