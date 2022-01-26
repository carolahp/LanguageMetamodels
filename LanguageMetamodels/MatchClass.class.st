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
	^ nil
]

{ #category : #hooks }
MatchClass >> defaultMetaclass [
	
	^ self parent ensureClassNamed: self name , self parent class metaclassSuffix
]

{ #category : #hooks }
MatchClass >> defaultSuperclass [
	^ self parent classProtoObject
]

{ #category : #initialization }
MatchClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	instVarsNames := ((anEP2MCClassDefinition variables
		select: #isInstanceVariable) collect: #name) asArray
]

{ #category : #hooks }
MatchClass >> initialize [ 
	super initialize.
	name := objectName.
	"ensure metaclass exists in language"
	self metaclass.
	^ self
]

{ #category : #initialization }
MatchClass >> initializeCustom [
	self metaclass initializeWithSoleInstance: self
]

{ #category : #hooks }
MatchClass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #accessing }
MatchClass >> instVarsNames [
	^ instVarsNames
]

{ #category : #install }
MatchClass >> installCustom [
	super installCustom
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
