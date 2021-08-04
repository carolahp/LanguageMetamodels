Class {
	#name : #CandleFromObjVLispClass,
	#superclass : #ClassModel,
	#instVars : [
		'name',
		'instVarsNames',
		'classVars'
	],
	#category : #'LanguageMetamodels-CandleFromObjVLisp'
}

{ #category : #binding }
CandleFromObjVLispClass >> bindingOf: aString [ 
	^ nil
]

{ #category : #accessing }
CandleFromObjVLispClass >> classVars [
	^ classVars
]

{ #category : #accessing }
CandleFromObjVLispClass >> classVars: anObject [
	classVars := anObject
]

{ #category : #hooks }
CandleFromObjVLispClass >> defaultMetaclass [
	^ self parent ensureMetaclassNamed: self name , self parent class metaclassSuffix
]

{ #category : #hooks }
CandleFromObjVLispClass >> defaultSuperclass [
	^ self parent classProtoObject
]

{ #category : #initialization }
CandleFromObjVLispClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	| mcDef classVarsDict |
	mcDef := anEP2MCClassDefinition.
	
	classVarsDict := mcDef classVars
		ifNil: [ Dictionary new ]
		ifNotNil: [ :vars | 
			(vars
				collect: [ :v | 
					self parent
						newClassVariableNamed: v asSymbol
						parent: self ]) asDictionary ].
	self classVars: classVarsDict.
	^ self
]

{ #category : #hooks }
CandleFromObjVLispClass >> initialize [ 
	super initialize.
	name := objectName.
	self defaultMetaclass initializeWithSoleInstance: self.
	^ self
]

{ #category : #hooks }
CandleFromObjVLispClass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #install }
CandleFromObjVLispClass >> installCustom [
	^ nil
]

{ #category : #become }
CandleFromObjVLispClass >> isMetaclass [ 
	^ self allSuperclasses includes: (self parent classMetaclass)
]

{ #category : #accessing }
CandleFromObjVLispClass >> metaclass [
	^ self defaultMetaclass
]

{ #category : #hooks }
CandleFromObjVLispClass >> registerCustom [
	^ nil
]
