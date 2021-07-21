Class {
	#name : #DynamicVariableModel,
	#superclass : #TempVariableModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #instanciation }
DynamicVariableModel class >> named: aString parent: anEP2MLanguage [ 
self haltIf:[aString = 'activeProcess'].
	^ self basicNew
		name: aString asSymbol;
		parent: anEP2MLanguage;
		initialize;
		yourself
]

{ #category : #'accessing-api' }
DynamicVariableModel >> asRemoteObjectInObjectSpace: anEP2ObjectSpace [
	| nameInstVarIndex indexInstVarIndex |
	" the index of the instance variable 'name' in the class DynVar "
	nameInstVarIndex := 1.
	" the index of the instance variable 'index' in the class DynVar "
	indexInstVarIndex := 2.
	remote := (self parent classNamed: 'DynVar') ensureRemote basicNew.
	remote
		instanceVariableAtIndex: nameInstVarIndex
		put: (objectName asRemoteObjectInObjectSpace: anEP2ObjectSpace).
	remote
		instanceVariableAtIndex: indexInstVarIndex
		put: (index asRemoteObjectInObjectSpace: anEP2ObjectSpace).

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
		send: #writeVar:value:
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitValue: methodBuilder [
	methodBuilder
		pushLiteralVariable: (AdditionalBinding key: #dynvar value: (self asRemoteObjectInObjectSpace: self parent objectSpace));
		pushReceiver;
		send: #read:
]
