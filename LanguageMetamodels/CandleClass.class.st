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
	self name1: self name.
	self instVarNames1: mcDef instVars.
	self classVariables1: mcDef classVars.
	self metaclass extendWithMonticelloCustom: anEP2MCClassDefinition.
	^ self
]

{ #category : #initialization }
CandleClass >> initialize [ 
	super initialize.
	self name1: self name
]

{ #category : #initialization }
CandleClass >> initializeWithTemplateCustom: aTemplateClass [
	
	self instVarNames1: aTemplateClass instVarNames.
	self classVariables1: #().
	self name1: self name.
	self parent ensureClassNamed: self name, self parent metaclassSuffix.
	self metaclass initializeWithSoleInstance: self.
	^ self
]

{ #category : #hooks }
CandleClass >> innerBindingOf: aString [ 
	^ nil
]

{ #category : #accessing }
CandleClass >> instVarNames1 [
	^ instVarNames
]

{ #category : #accessing }
CandleClass >> instVarNames1: anObject [
	instVarNames := anObject
]

{ #category : #testing }
CandleClass >> isCandleMetaclass [
	^ false
]

{ #category : #accessing }
CandleClass >> metaclass [
	^ self parent ensureClassNamed: self name1 , self parent metaclassSuffix
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
	self assert: (self parent isValidMetaclassName: self name1) not
"	self assert: self classVariables1 isArray.
	self assert: self instVarNames1 isNotNil.
	self assert: self instVarNames1 isArray"
]
