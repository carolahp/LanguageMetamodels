"
ObjVLisp with first class instance variables, as slots
"
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
	self transformObjectModel.
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
	classModel
		addLocalMethodFromSource:
			'slotNamed: aSymbol
			^ (self allSlots 
				select: [:slot | slot name = aSymbol asSymbol ]) anyOne'
		selector: #slotNamed:.
	
]

{ #category : #hooks }
ObjVLispSlotsLanguage >> transformObjectModel [
	| objectModel |
	objectModel := self classProtoObject.
	objectModel
		addLocalMethodFromSource:
			'writeSlot: aSlot value: anObject
	^aSlot write: anObject to: self'
		selector: #writeSlot:value:
]

{ #category : #hooks }
ObjVLispSlotsLanguage >> transformSlotModel [
	| slotModel |
	slotModel := self classNamed: #InstanceVariableSlot.
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
	
	slotModel
		addLocalMethodFromSource:
			'read: anObject
			^ thisContext object: anObject instVarAt: index'
		selector: #read:.
	slotModel
		addLocalMethodFromSource:
			'write: aValue to: anObject
			^ thisContext object: anObject instVarAt: index put: aValue'
		selector: #write:to:.
	
]
