Class {
	#name : #ObjVLispSlotsClass,
	#superclass : #ObjVLispMinClass,
	#instVars : [
		'slots'
	],
	#category : #'LanguageMetamodels-ObjVLispSlots'
}

{ #category : #instanciation }
ObjVLispSlotsClass class >> customFirstClassModels [
	^ { self instanceVariableSlotModel }
]

{ #category : #instanciation }
ObjVLispSlotsClass class >> instanceVariableSlotModel [
	^ InstanceVariableSlotModel
]

{ #category : #binding }
ObjVLispSlotsClass >> addSlotRecursivelyWherePossible: aSlot [
	| insert required |
	self
		recursivellyDo: [ :class | 
			insert := class acceptsNewSlots.
			class allSubclasses
				do: [ :subclass | 
					insert := insert and: subclass acceptsNewSlots.
					required := subclass role
						ifNil: [ #() ]
						ifNotNil: [ subclass role modelInstVarNames ].
					insert := insert and: (required endsWith: class allSlots) ].
			insert
				ifTrue: [ class slotNamed: aSlot name ifAbsent: [ class addSlot: aSlot ] ] ]
		to: [ :c | c subclasses ]
]

{ #category : #binding }
ObjVLispSlotsClass >> initialize [ 
	super initialize.
	slots := self slots
]
