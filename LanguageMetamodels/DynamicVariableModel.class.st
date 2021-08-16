Class {
	#name : #DynamicVariableModel,
	#superclass : #TempVariableModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
DynamicVariableModel class >> allModelInstVarNames [
	^ #(#index #name)
]

{ #category : #layout }
DynamicVariableModel class >> defaultLayout [
	^ EP2FixedLayout
]

{ #category : #instanciation }
DynamicVariableModel class >> named: aString parent: anEP2MLanguage [ 

	^ self basicNew
		name: aString asSymbol;
		parent: anEP2MLanguage;
		initialize;
		yourself
]

{ #category : #instanciation }
DynamicVariableModel class >> role [ 
	^ 'DynamicVariable'
]

{ #category : #'accessing-api' }
DynamicVariableModel >> asRemoteObjectInObjectSpace: anEP2ObjectSpace [ 
	remote := ((self parent classNamed: 'DynVar') ensureRemote basicNew).
	remote instanceVariableAtIndex: 1 put: (objectName asRemoteObjectInObjectSpace: anEP2ObjectSpace).
	remote instanceVariableAtIndex: 2 put: (index asRemoteObjectInObjectSpace: anEP2ObjectSpace).
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
		"pushReceiver;"
		pushLiteralVariable: (AdditionalBinding key: #dynvar value: (self asRemoteObjectInObjectSpace: self environment objectSpace));
		pushTemp: tempName;
		send: #write:
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitValue: methodBuilder [
	methodBuilder
		pushLiteralVariable: (AdditionalBinding key: #dynvar value: (self asRemoteObjectInObjectSpace: self parent objectSpace));
		"pushReceiver;"
		send: #read
]

{ #category : #accessing }
DynamicVariableModel >> index [
	^ index
]

{ #category : #accessing }
DynamicVariableModel >> index: anInteger [ 
	index := anInteger
]

{ #category : #'accessing-api' }
DynamicVariableModel >> initialize [ 
	super initialize.
	name := objectName
]

{ #category : #accessing }
DynamicVariableModel >> name [
	^ name
]
