Class {
	#name : #OldCandleExplicitMetaclassesClass,
	#superclass : #ExplicitMetaclassesClass,
	#instVars : [
		'name',
		'instVarNames',
		'classVariables'
	],
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> classVariables [
	^ classVariables
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> classVariables: aCollection [ 
	classVariables := aCollection
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> extendWithMonticelloCustom: aMCClassDefinition [ 
	| mcDef |
	super extendWithMonticelloCustom: aMCClassDefinition.
	mcDef := aMCClassDefinition.
	self instVarNames: mcDef instVarNames.
	self classVariables: nil
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> hookInstall [
	super hookInstall.
	
	self remote 
		name: (self toRemoteObject: self name asSymbol);
		instVarNames: (self toRemoteObject: self instVarNames asArray);
		classVariables: (self toRemoteObject: self classVariables).
	^ self remote
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> initializeWithTemplateCustom: aTemplate [
	super initializeWithTemplateCustom: aTemplate.
	self instVarNames: aTemplate instVarNames. 
	self classVariables: nil
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> instVarNames1 [
	^ instVarNames
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> instVarNames: aCollection [ 
	instVarNames := aCollection
]

{ #category : #accessing }
OldCandleExplicitMetaclassesClass >> testRemote [
	| remoteObject remoteName remoteInstVars |
	super testRemote.
	remoteObject := self remote.
	remoteName := (remoteObject instanceVariableNamed: #name).
	self assert: remoteName isNotNilObject.
	self assert: remoteName basicClass = (self parent remote classNamed: #ByteSymbol).
	remoteInstVars := (remoteObject instanceVariableNamed: #instVarNames).
	self assert: remoteInstVars isNotNilObject.
	self assert: remoteInstVars basicClass = (self parent remote classNamed: #Array)
]
