Class {
	#name : #ObjVLispSlotsSlot,
	#superclass : #SlotModel,
	#category : #'LanguageMetamodels-ObjVLispSlots'
}

{ #category : #testing }
ObjVLispSlotsSlot >> printOn: aStream [
	aStream
		nextPutAll: objectName;
		nextPutAll: ' => ';
		nextPutAll: self slotName
]

{ #category : #testing }
ObjVLispSlotsSlot >> slotName [ 
	'OwnerSlot'
]
