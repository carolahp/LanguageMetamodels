Class {
	#name : #CandleFromObjVLispClass,
	#superclass : #ClassModel,
	#instVars : [
		'name',
		'instVarsNames'
	],
	#category : #'LanguageMetamodels-CandleFromObjVLisp'
}

{ #category : #binding }
CandleFromObjVLispClass >> bindingOf: varName [ 
	| aSymbol |
	aSymbol := varName asSymbol.

	^ self environment bindingOf: aSymbol
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
	^ self
]

{ #category : #hooks }
CandleFromObjVLispClass >> initialize [ 
	super initialize.
	name := objectName.
	self metaclass initializeWithSoleInstance: self.
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

{ #category : #accessing }
CandleFromObjVLispClass >> isCandleClass [
	^ true
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
CandleFromObjVLispClass >> package: aPackageModel [
	super package: aPackageModel.
	self metaclass package: aPackageModel
]

{ #category : #hooks }
CandleFromObjVLispClass >> registerCustom [
	^ nil
]

{ #category : #hooks }
CandleFromObjVLispClass >> test [
	super test.
	self assert: self metaclass isCandleClass not.
	self assert: (self parent isValidMetaclassName: self name) not.
	self assert: (self allSuperclasses includes: self parent classClass) not
]
