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

{ #category : #become }
CandleFromObjVLispClass >> becomeMetaclass [
	| newMetaclass newName |
	self halt.
	self assert: self metaclass = self parent classMetaclass.
	newName := self name copyReplaceAll: 'Meta' with: self parent class metaclassSuffix.
	newMetaclass := self parent ensureMetaclassNamed: newName.
	self halt.
	self parent removeBehavior: self.
	
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

{ #category : #hooks }
CandleFromObjVLispClass >> initialize [ 
	super initialize.
	"metaclass ifNil: [ metaclass := self defaultMetaclass ].
	superclass ifNil: [ superclass := self defaultSuperclass ]."
]

{ #category : #initialization }
CandleFromObjVLispClass >> initializeWithTemplateCustom: aTemplateClass [
	
	self classVars: #().
	self metaclass: (self parent ensureClassNamed: self parent classMetaclass name).
	"self parent ensureClassNamed: self name, self parent class metaclassSuffix."
	"self metaclass initializeWithSoleInstance: self."
	^ self
]

{ #category : #hooks }
CandleFromObjVLispClass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #become }
CandleFromObjVLispClass >> isMetaclass [ 
	^ self allSuperclasses includes: (self parent classWithRole: #Metaclass)
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
