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

{ #category : #'hooks-api' }
ObjVLispMILanguage class >> classModelFor: aString [
	^ (aString endsWith: self multiclassSuffix)
		ifTrue: [ self multiclassModel ]
		ifFalse: [ self classModel ]
]

{ #category : #'hooks-api' }
ObjVLispMILanguage class >> multiclassModel [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispMIMulticlass  
]

{ #category : #'hooks-api' }
ObjVLispMILanguage class >> multiclassSuffix [
	^ 'Multi'
]

{ #category : #hooks }
ObjVLispMILanguage >> transform [
	| slotModel classModel dogMultiModel objectModel |
	super transform.
	objectModel := self classProtoObject.
	objectModel
		addLocalMethodFromSource:
			'writeSlot: aSlot value: anObject
	^aSlot write: anObject to: self'
		selector: #writeSlot:value:.
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
				nextPutAll: name;
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
	dogMultiModel := self ensureClassNamed: #DogMulti.
	dogMultiModel addSlot: #address.
	dogMultiModel
		addLocalMethodFromSource:
			'address
		^ address'
		selector: #address.
	dogMultiModel
		addLocalMethodFromSource:
			'address: aString
		^ address := aString'
		selector: #address:
]
