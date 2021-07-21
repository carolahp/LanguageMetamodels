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
	
	name = 'holahola'
		ifTrue: [ | tempName |
			tempName := '0slotTempForStackManipulation'.
			methodBuilder
				addTemp: tempName;
				storeTemp: tempName;
				popTop;
				"pushReceiver;"
				pushLiteralVariable:
					(AdditionalBinding
						key: name
						value: (self asRemoteObjectInObjectSpace: self environment objectSpace));
				pushTemp: tempName;
				send: #write: ]
		ifFalse: [ methodBuilder storeTemp: name ]
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitValue: methodBuilder [
	name = 'holahola'
		ifTrue: [ 
			methodBuilder
				pushLiteralVariable:
					(AdditionalBinding
						key: name
						value: (self asRemoteObjectInObjectSpace: self parent objectSpace));
				"pushReceiver;"
				send: #read ]
		ifFalse: [ methodBuilder pushTemp: name ]
]

{ #category : #testing }
DynamicVariableModel >> isLiteralVariable [
	^false
]

{ #category : #testing }
DynamicVariableModel >> isUndeclared [

	^ false
]

{ #category : #asd }
DynamicVariableModel >> markRead [
	"reading does not change a #write, nor an #arg"
	usage ifNil: [usage := #read]
]
