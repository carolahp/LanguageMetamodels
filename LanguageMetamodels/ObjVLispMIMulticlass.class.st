Class {
	#name : #ObjVLispMIMulticlass,
	#superclass : #ObjVLispMIClass,
	#category : #'LanguageMetamodels-ObjVLispMI'
}

{ #category : #metamodel }
ObjVLispMIMulticlass class >> instanceVariableSlotModel [
	^ ObjVLispMIInstanceVariableSlot 
]

{ #category : #'bootstrap - build model fields' }
ObjVLispMIMulticlass >> addSlot: aString [
	super addSlot: aString.
	slots := slots asOrderedCollection
		add: (self slotNamed: aString);
		asArray
]
