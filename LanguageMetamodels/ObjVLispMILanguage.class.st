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
	super transform.
	self transformObjectModel.
	self transformSlotModel.
	self transformClassModel.
	self transformMulticlassModel.
	self transformMulticlasses
]

{ #category : #hooks }
ObjVLispMILanguage >> transformClassModel [
	| classModel |
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

{ #category : #hooks }
ObjVLispMILanguage >> transformMulticlassModel [
	| multiclassModel |
	multiclassModel := self ensureClassNamed: #Multiclass.
	multiclassModel metaclass: self classClass.
	multiclassModel superclass: self classClass.
	multiclassModel addSlot: #superclasses.
	multiclassModel
		addLocalMethodFromSource:
			'superclasses
			^ superclasses'
		selector: #superclasses
]

{ #category : #hooks }
ObjVLispMILanguage >> transformMulticlasses [
	| animalMultiModel petMultiModel dogMultiModel |
	
	" Animal "
	animalMultiModel := self ensureClassNamed: #AnimalMulti.
	animalMultiModel addSlot: #color.
	animalMultiModel
		addLocalMethodFromSource:
			'color
		^ color'
		selector: #color.
	animalMultiModel
		addLocalMethodFromSource:
			'color: aString
		color := aString'
		selector: #color:.
	
	" Pet "
	petMultiModel := self ensureClassNamed: #PetMulti.
	petMultiModel addSlot: #address.
	petMultiModel addSlot: #name.
	petMultiModel
		addLocalMethodFromSource:
			'address
		^ address'
		selector: #address.
	petMultiModel
		addLocalMethodFromSource:
			'address: aString
		address := aString'
		selector: #address:.
	petMultiModel
		addLocalMethodFromSource:
			'address
		^ address'
		selector: #address.
	petMultiModel
		addLocalMethodFromSource:
			'name: aString
		name := aString'
		selector: #name:.
	petMultiModel
		addLocalMethodFromSource:
			'name
		^ name'
		selector: #name.
	
	" Dog "
	dogMultiModel := self ensureClassNamed: #DogMulti.
	dogMultiModel superclass: petMultiModel.
	dogMultiModel addSuperclass: animalMultiModel
	
]

{ #category : #hooks }
ObjVLispMILanguage >> transformObjectModel [
	| objectModel multiObject |
	objectModel := self classProtoObject.
	objectModel
		addLocalMethodFromSource:
			'writeSlot: aSlot value: anObject
	^aSlot write: anObject to: self'
		selector: #writeSlot:value:.
	
	multiObject := self ensureClassNamed: #MultiObject.
	multiObject superclass: self classProtoObject.
	multiObject metaclass: self classClass.
	multiObject addSlot: #instVarsDict.
	multiObject
		addLocalMethodFromSource:
			'instVarsDict
	^ instVarsDict'
		selector: #instVarsDict.
	multiObject addLocalMethodFromSource:
			'initialize
	super initialize.
	instVarsDict := Dictionary new'
		selector: #initialize.
	multiObject addLocalMethodFromSource:
			'doesNotUnderstand: aMessage
	System log: ''multiobject does not understand message''.
	System quit'
		selector: #doesNotUnderstand:.
	
	
]

{ #category : #hooks }
ObjVLispMILanguage >> transformSlotModel [
	| slotModel |
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
	
]
