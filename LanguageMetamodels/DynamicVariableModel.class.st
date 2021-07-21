Class {
	#name : #DynamicVariableModel,
	#superclass : #TempVariableModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #instanciation }
DynamicVariableModel class >> named: aString parent: anEP2MLanguage [ 

	^ self basicNew
		name: aString asSymbol;
		parent: anEP2MLanguage;
		initialize;
		yourself
]

{ #category : #'accessing-api' }
DynamicVariableModel >> asRemoteObjectInObjectSpace: anEP2ObjectSpace [ 
	remote := ((self parent classNamed: 'DynVar') ensureRemote basicNew).
	remote instanceVariableAtIndex: 1 put: (objectName asRemoteObjectInObjectSpace: anEP2ObjectSpace).
	^ remote
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitStore: methodBuilder [

	"generate bytecode to call the reflective write method of the Slot"
	| tempName |

	tempName := '0slotTempForStackManipulation'.  
	methodBuilder
		addTemp: tempName;
		storeTemp: tempName;
		popTop;
		pushReceiver;
		pushLiteralVariable: (AdditionalBinding key: #dynvar value: (self asRemoteObjectInObjectSpace: self environment objectSpace));
		pushTemp: tempName;
		send: #writeSlot:value:
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitValue: methodBuilder [
	methodBuilder
		pushLiteralVariable: (AdditionalBinding key: #dynvar value: (self asRemoteObjectInObjectSpace: self parent objectSpace));
		pushReceiver;
		send: #read:
]
