Class {
	#name : #ObjVLispMIInstanceVariableSlot,
	#superclass : #InstanceVariableSlotModel,
	#category : #'LanguageMetamodels-ObjVLispMI'
}

{ #category : #'as yet unclassified' }
ObjVLispMIInstanceVariableSlot >> emitStore: aMethodBuilder [
	"generate bytecode to call the reflective write method of the Slot"
	| tempName |
	tempName := '0slotTempForStackManipulation'.  
	aMethodBuilder
		addTemp: tempName;
		storeTemp: tempName;
		popTop;
		pushReceiver;
		pushLiteralVariable: (AdditionalBinding key: #slot value: self);
		pushTemp: tempName;
		send: #writeSlot:value:
]

{ #category : #'as yet unclassified' }
ObjVLispMIInstanceVariableSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushLiteralVariable: (AdditionalBinding key: #slot value: self);
		pushReceiver;
		send: #read:
]
