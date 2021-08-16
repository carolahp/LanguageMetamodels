Class {
	#name : #ObjVLispSlotsLanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispSlots'
}

{ #category : #'hooks-api' }
ObjVLispSlotsLanguage class >> classModel [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispSlotsClass  
]

{ #category : #hooks }
ObjVLispSlotsLanguage >> transform [ 
	super transform.
	self transformSlotModel.
	self transformClassModel 
]

{ #category : #hooks }
ObjVLispSlotsLanguage >> transformClassModel [
	| classModel |
	classModel := self classClass.
	classModel
		addLocalMethodFromSource:
			'allSlots
			self superclass 
				ifNil: [ ^ slots asOrderedCollection ].
			^ self superclass allSlots asOrderedCollection
				addAll: slots;
				asArray'
		selector: #allSlots.
	classModel
		addLocalMethodFromSource:
			'slots
			^ slots'
		selector: #slots.
	
]

{ #category : #hooks }
ObjVLispSlotsLanguage >> transformSlotModel [
	| slotModel |
	slotModel := self classNamed: #InstanceVariableSlot.
	slotModel
		addLocalMethodFromSource:
			'read: anObject
			^ anObject instVarsDict at: name'
		selector: #read:.
	slotModel
		addLocalMethodFromSource:
			'write: aValue to: anObject
			^ anObject instVarsDict at: name put: aValue'
		selector: #write:to:.
	slotModel
		addLocalMethodFromSource:
			'printOn: aStream
			aStream 
				nextPutAll: name;
				nextPutAll: '' => '';
				nextPutAll: self class name'
		selector: #printOn:.
	slotModel
		addLocalMethodFromSource:
			'name
				^ name'
		selector: #name.
]
