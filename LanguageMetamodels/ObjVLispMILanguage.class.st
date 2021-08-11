Class {
	#name : #ObjVLispMILanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispMI'
}

{ #category : #'hooks-api' }
ObjVLispMILanguage class >> classModel [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispMIClass  
]

{ #category : #hooks }
ObjVLispMILanguage >> transform [
	| slotModel classModel |
	super transform.
	slotModel := self classNamed: #InstanceVariableSlot.
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
	slotModel
		addLocalMethodFromSource: 
		'printOn: aStream
			aStream 
				store: name;
				nextPutAll: '' => '';
				nextPutAll: self class name'
		selector: #printOn:.
	classModel := self classClass.
	classModel
		addLocalMethodFromSource:
		'allSlots
			self superclass 
				ifNil: [ ^ slots asOrderedCollection ].
			^ self superclass allSlots
				addAll: slots;
				yourself'
		selector: #allSlots.
	classModel
		addLocalMethodFromSource:
		'slots
			^ slots'
		selector: #slots.
	
]
