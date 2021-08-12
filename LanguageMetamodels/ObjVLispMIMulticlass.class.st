Class {
	#name : #ObjVLispMIMulticlass,
	#superclass : #ObjVLispMIClass,
	#instVars : [
		'superclasses'
	],
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

{ #category : #'bootstrap - build model fields' }
ObjVLispMIMulticlass >> addSuperclass: aMulticlass [
	superclasses := superclasses asOrderedCollection
		add: aMulticlass;
		asArray
]

{ #category : #'bootstrap - build model fields' }
ObjVLispMIMulticlass >> initialize [ 
	super initialize.
	self metaclass: (self parent classNamed: #Multiclass).
	self superclass: (self parent classNamed: #MultiObject).
	superclasses := #()
]

{ #category : #'bootstrap - build model fields' }
ObjVLispMIMulticlass >> superclasses [
	^ superclasses
]
