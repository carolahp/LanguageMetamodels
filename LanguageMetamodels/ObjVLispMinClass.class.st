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
	self assert: (self name isNil or: [self name = anEP2MCClassDefinition name]).
	self
		metaclass:
			(metaclassDef
				ifNotNil: [ self parent ensureClassNamed: metaclassDef ]
				ifNil: [ self parent classClass ]).
]

{ #category : #binding }
ObjVLispMinClass >> initialize [
	super initialize.
	self assert: objectName isNotNil.
	name := objectName.
	metaclass := self parent classClass
]

{ #category : #hooks }
ObjVLispMinClass >> innerBindingOf: aSymbol [ 
	" no classPool, nor classVars"
	^ nil
]

{ #category : #initialization }
ObjVLispMinClass >> metaclass [
	^ metaclass
]

{ #category : #initialization }
ObjVLispMinClass >> metaclass: anObject [
	metaclass := anObject 
]
