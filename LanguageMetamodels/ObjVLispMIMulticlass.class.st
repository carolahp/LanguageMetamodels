Class {
	#name : #ObjVLispMIMulticlass,
	#superclass : #ObjVLispMIClass,
	#instVars : [
		'superclasses'
	],
	#category : #'LanguageMetamodels-ObjVLispMultipleInheritance'
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
		asArray.
	aMulticlass methodDict
		do: [ :method | self methodDict at: method selector ifAbsentPut: method ]
]

{ #category : #'bootstrap - build model fields' }
ObjVLispMIMulticlass >> allSlots [
	| result |
	" slots inherited by normal inheritance are prioritized. 
	slots inherited from extra superclasses are prioritized in the order in which the superclasses were defined "
	
	" first get my slots plus slots inherited by normal inheritance "
	result := super allSlots asOrderedCollection.
	
	" add slots inherited from extra superclasses "
	self superclasses
		do: [ :class | 
			class allSlots
				do: [ :slot | 
					(result noneSatisfy: [ :mySlot | mySlot name = slot name ])
						ifTrue: [ result add: slot ] ] ].
	^ result asArray
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
