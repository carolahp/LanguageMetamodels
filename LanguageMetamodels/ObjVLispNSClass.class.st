Class {
	#name : #ObjVLispNSClass,
	#superclass : #ObjVLispMinClass,
	#instVars : [
		'package'
	],
	#category : #'LanguageMetamodels-ObjVLispNamespaces'
}

{ #category : #'accessing-api' }
ObjVLispNSClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [ 
	| mcDef metaclassDef |
	mcDef := anEP2MCClassDefinition.
	metaclassDef := mcDef metaclass.
	self assert: (self name isNil or: [self name endsWith: anEP2MCClassDefinition name]).
	self
		metaclass:
			(metaclassDef
				ifNotNil: [ self parent ensureClassNamed: metaclassDef ]
				ifNil: [ self parent classClass ]).
]

{ #category : #'accessing-api' }
ObjVLispNSClass >> name [ 
	^ self package name, '>', objectName
]
