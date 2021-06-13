Class {
	#name : #CandleClass,
	#superclass : #ClassModel,
	#instVars : [
		'name',
		'instVarNames',
		'classVariables'
	],
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #accessing }
CandleClass >> classVariables1 [
	^ classVariables
]

{ #category : #accessing }
CandleClass >> classVariables1: anObject [
	classVariables := anObject
]

{ #category : #hooks }
CandleClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [ 
	| mcDef |
	mcDef := anEP2MCClassDefinition.
	self instVarNames1: mcDef instVars.
	self classVariables1: mcDef classVars.
	self halt.
	^ self
]

{ #category : #initialization }
CandleClass >> initializeWithTemplateCustom: aTemplateClass [
	| myMetaclass |
	self instVarNames1: aTemplateClass instVarNames.
	self classVariables1: #().
	self name1: self name.
	myMetaclass := self parent newMetaclassFor: self.
	self parent
		classNamed: myMetaclass name
		ifAbsent: [ self parent addBehavior: myMetaclass ].
	^ self
]

{ #category : #accessing }
CandleClass >> instVarNames1 [
	^ instVarNames
]

{ #category : #accessing }
CandleClass >> instVarNames1: anObject [
	instVarNames := anObject
]

{ #category : #accessing }
CandleClass >> metaclass [
	^ self parent classNamed: self name1 , self parent metaclassSuffix
]

{ #category : #accessing }
CandleClass >> name1 [
	^ name
]

{ #category : #accessing }
CandleClass >> name1: anObject [
	name := anObject
]

{ #category : #accessing }
CandleClass >> test [ 
	super test.
	self assert: self metaclass isNotNil.
	self assert: self name1 isNotNil.
	self assert: self name1 = self name.
	self assert: self classVariables1 isArray.
	self assert: self instVarNames1 isNotNil.
	self assert: self instVarNames1 isArray
]
