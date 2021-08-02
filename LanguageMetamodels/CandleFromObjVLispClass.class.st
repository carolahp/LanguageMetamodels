Class {
	#name : #CandleFromObjVLispClass,
	#superclass : #ClassModel,
	#instVars : [
		'name',
		'instVarsNames',
		'classVars',
		'metaclass'
	],
	#category : #'LanguageMetamodels-CandleFromObjVLisp'
}

{ #category : #accessing }
CandleFromObjVLispClass >> classVars [
	^ classVars
]

{ #category : #accessing }
CandleFromObjVLispClass >> classVars: anObject [
	classVars := anObject
]

{ #category : #initialization }
CandleFromObjVLispClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	| mcDef classVarsDict |
	mcDef := anEP2MCClassDefinition.
	self name: self name.
	classVarsDict := mcDef classVars
		ifNil: [ Dictionary new ]
		ifNotNil: [ :vars | 
			(vars
				collect: [ :v | 
					self parent
						newClassVariableNamed: v asSymbol
						parent: self ]) asDictionary ].
	self classVars: classVarsDict.

	self metaclass: (self parent ensureClassNamed: anEP2MCClassDefinition metaclass).
	"self metaclass extendWithMonticelloCustom: anEP2MCClassDefinition."
	^ self
]

{ #category : #initialization }
CandleFromObjVLispClass >> initializeWithTemplateCustom: aTemplateClass [
	
	self classVars: #().
	self metaclass: (self parent ensureClassNamed: self parent classMetaclass).
	"self parent ensureClassNamed: self name, self parent class metaclassSuffix."
	"self metaclass initializeWithSoleInstance: self."
	^ self
]

{ #category : #accessing }
CandleFromObjVLispClass >> metaclass [
	^ metaclass
	"^ self parent ensureClassNamed: self name , self parent class metaclassSuffix"
]

{ #category : #metaclass }
CandleFromObjVLispClass >> metaclass: aCandleFromObjVLispClass [ 
	metaclass := aCandleFromObjVLispClass
]
