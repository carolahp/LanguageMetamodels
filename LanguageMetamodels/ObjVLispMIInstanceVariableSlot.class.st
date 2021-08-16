Class {
	#name : #ObjVLispMIInstanceVariableSlot,
	#superclass : #InstanceVariableSlotModel,
	#category : #'LanguageMetamodels-ObjVLispMultipleInheritance'
}

{ #category : #'code generation' }
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

{ #category : #'code generation' }
ObjVLispMIInstanceVariableSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushLiteralVariable: (AdditionalBinding key: #slot value: self);
		pushReceiver;
		send: #read:
]
