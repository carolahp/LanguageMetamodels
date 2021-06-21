Class {
	#name : #ObjVLispMinClass,
	#superclass : #ClassModel,
	#instVars : [
		'metaclass',
		'name'
	],
	#category : #'LanguageMetamodels-ObjVLispMin'
}

{ #category : #binding }
ObjVLispMinClass >> bindingOf: varName [ 
	| aSymbol |
	aSymbol := varName asSymbol.

	^ self environment bindingOf: aSymbol
]

{ #category : #hooks }
ObjVLispMinClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [ 
	| mcDef metaclassDef |
	mcDef := anEP2MCClassDefinition.
	metaclassDef := mcDef metaclass.
	self
		metaclass:
			(metaclassDef
				ifNotNil: [ self parent ensureClassNamed: metaclassDef ]
				ifNil: [ self parent classMetaclass ]).
]

{ #category : #initialization }
ObjVLispMinClass >> initializeWithTemplateCustom: aTemplate [
	
	self metaclass: self parent classMetaclass
]

{ #category : #hooks }
ObjVLispMinClass >> innerBindingOf: aSymbol [ 
	" no classPool, nor classVars"
	^ nil
]

{ #category : #install }
ObjVLispMinClass >> installCustom [
	^ nil
]

{ #category : #hooks }
ObjVLispMinClass >> installStubCustom [

	self deprecated: 'Use LanguageModel >> installMulticlassStubs:'.
	self metaclass = self
		ifTrue: [ ^ self installMetacircularStub ].
	"first install the stub of my metaclass"
	self metaclass installStub.
	"instantiate my metaclass to create a stub of me"
	^ self metaclass newStubWithFormat: self format.
	
]

{ #category : #initialization }
ObjVLispMinClass >> metaclass [
	^ metaclass
]

{ #category : #initialization }
ObjVLispMinClass >> metaclass: anObject [
	metaclass := anObject 
]
