Class {
	#name : #DynamicVariableModel,
	#superclass : #TempVariableModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
DynamicVariableModel class >> acceptsUndeclaredReferences [
	^ true
]

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

{ #category : #metamodel }
DynamicVariableModel class >> newFrom: aEBVariableNode inContext: anEP2CompilationContext [
	| node context |
	node := aEBVariableNode.
	context := anEP2CompilationContext.
	node methodOrBlockNode isBlock
		ifTrue: [ ^ super
				newFrom: aEBVariableNode
				inContext: anEP2CompilationContext ].
	^ (self 
		named: node name 
		parent: context environment)
		index: (node temporaryVariables indexOf: node name); "index 0 means that the variable was not defined in the method, it is a dynamic var!"
		yourself
]

{ #category : #instanciation }
DynamicVariableModel class >> role [ 
	^ 'DynamicVariable'
]

{ #category : #'accessing-api' }
DynamicVariableModel >> asRemoteObjectInObjectSpace: anEP2ObjectSpace [ 
	remote := ((self parent classWithRole: 'DynamicVariable') ensureRemote basicNew).
	remote name: self name.
	remote index: self index.
	^ remote
]

{ #category : #'accessing-api' }
DynamicVariableModel >> asUndeclaredReference [
 	self index: 0. "index 0 means the temp is not defined in the method"
	^ self	
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
		pushLiteralVariable:
			(AdditionalBinding
				key: #dynvar
				value: (self asRemoteObjectInObjectSpace: self environment objectSpace));
		pushTemp: tempName;
		send: #write:
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitValue: methodBuilder [
	methodBuilder
		pushLiteralVariable:
			(AdditionalBinding
				key: #dynvar
				value: (self asRemoteObjectInObjectSpace: self parent objectSpace));
			send: #read
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
