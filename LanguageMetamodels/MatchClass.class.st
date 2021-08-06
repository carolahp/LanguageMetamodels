Class {
	#name : #MatchClass,
	#superclass : #ClassModel,
	#instVars : [
		'name',
		'instVarsNames'
	],
	#category : #'LanguageMetamodels-Match'
}

{ #category : #binding }
MatchClass >> bindingOf: varName [ 
	| aSymbol |
	aSymbol := varName asSymbol.

	^ self environment bindingOf: aSymbol
]

{ #category : #hooks }
MatchClass >> defaultMetaclass [
	^ self parent ensureMetaclassNamed: self name , self parent class metaclassSuffix
]

{ #category : #hooks }
MatchClass >> defaultSuperclass [
	^ self parent classProtoObject
]

{ #category : #initialization }
MatchClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	^ self
]

{ #category : #hooks }
MatchClass >> initialize [ 
	super initialize.
	name := objectName.
	self metaclass initializeWithSoleInstance: self.
	^ self
]

{ #category : #hooks }
MatchClass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #install }
MatchClass >> installCustom [
	^ nil
]

{ #category : #accessing }
MatchClass >> isCandleClass [
	^ true
]

{ #category : #become }
MatchClass >> isMetaclass [ 
	^ self allSuperclasses includes: (self parent classMetaclass)
]

{ #category : #accessing }
MatchClass >> metaclass [
	^ self defaultMetaclass
]

{ #category : #hooks }
MatchClass >> package: aPackageModel [
	super package: aPackageModel.
	self metaclass package: aPackageModel
]

{ #category : #hooks }
MatchClass >> registerCustom [
	^ nil
]

{ #category : #hooks }
MatchClass >> test [
	super test.
	self assert: self metaclass isCandleClass not.
	self assert: (self parent isValidMetaclassName: self name) not.
	self assert: (self allSuperclasses includes: self parent classClass) not
]
