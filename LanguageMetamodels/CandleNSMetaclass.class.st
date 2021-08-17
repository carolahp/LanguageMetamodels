Class {
	#name : #CandleNSMetaclass,
	#superclass : #CandleMetaclass,
	#instVars : [
		'package'
	],
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

{ #category : #hooks }
CandleNSMetaclass >> = aCandleNSMetaclass [
	(aCandleNSMetaclass class == self class) ifFalse: [ ^ false ].
	^ self fullName = aCandleNSMetaclass fullName
]

{ #category : #hooks }
CandleNSMetaclass >> binding [
	^ self environment environment newGlobalBindingFor: self name asSymbol
]

{ #category : #hooks }
CandleNSMetaclass >> bindingOf: varName [
	^ soleInstance bindingOf: varName asSymbol
]

{ #category : #hooks }
CandleNSMetaclass >> environment [
	^ self soleInstance environment
]

{ #category : #hooks }
CandleNSMetaclass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	| mcDef mcDefNew superclassName |
	mcDef := anEP2MCClassDefinition.
	superclassName := mcDef superclassName = #nil
		ifTrue: [ self defaultSuperclassName ]
		ifFalse: [ mcDef superclassName , self parent metaclassSuffix ].
	mcDefNew := EP2MCClassDefinition
		name: mcDef className , self parent metaclassSuffix
		superclassName: superclassName
		category: mcDef category
		instVarNames: #()
		comment: ''.
	self extendWithMonticello: mcDefNew.
	self
		soleInstance:
			(self parent
				classNamed:
					(self fullName
						copyReplaceAll: self parent class metaclassSuffix
						with: '')).
	^ self
]

{ #category : #hooks }
CandleNSMetaclass >> fullName [
	^ self package name, '>', objectName
]

{ #category : #hooks }
CandleNSMetaclass >> initialize [ 
	package ifNil: [ package := self parent defaultPackage ].
	super initialize
]

{ #category : #hooks }
CandleNSMetaclass >> initializeCustom [ 
	self
		initializeWithSoleInstance:
			(self parent
				classNamed: (self fullName copyReplaceAll: self parent class metaclassSuffix with: ''))
]

{ #category : #hooks }
CandleNSMetaclass >> installCustom [
	self halt.
]

{ #category : #hooks }
CandleNSMetaclass >> name [
	^ objectName
]

{ #category : #hooks }
CandleNSMetaclass >> name: aString [
	| name |
	name := (aString asString copyReplaceAll: 'Kernel>' with: '') asSymbol. 
	super name: name
]

{ #category : #hooks }
CandleNSMetaclass >> package [ 
	^ package ifNil: [ 
		self package: self parent defaultPackage.
		self package ]
]

{ #category : #hooks }
CandleNSMetaclass >> package: aCandleNSPackage [
	package ifNotNil: [ package removeDefinedBehavior: self ].
	package := aCandleNSPackage.
	package addDefinedBehavior: self
]

{ #category : #hooks }
CandleNSMetaclass >> registerCustom [
	^ ((self parent globalVariableNamed: #Smalltalk) remote
		instanceVariableAtIndex: 2) asRemoteDictionary
		at: self name asSymbol
		put: self remote
]
