Class {
	#name : #CandleClass,
	#superclass : #ClassModel,
	#instVars : [
		'name',
		'instVarsNames',
		'classVars'
	],
	#category : #'LanguageMetamodels-Candle'
}

{ #category : #accessing }
CandleClass >> classVars [
	^ classVars
]

{ #category : #accessing }
CandleClass >> classVars: anObject [
	classVars := anObject
]

{ #category : #hooks }
CandleClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	| mcDef classVarsDict |
	mcDef := anEP2MCClassDefinition.
	self name: self name.
	self instVarsNames: mcDef instVars.
	classVarsDict := mcDef classVars
		ifNil: [ Dictionary new ]
		ifNotNil:
			[ :vars | (vars collect: [ :v | v asSymbol -> nil ]) asDictionary ].
	self classVars: classVarsDict.
	self metaclass extendWithMonticelloCustom: anEP2MCClassDefinition.
	^ self
]

{ #category : #'initialize remote' }
CandleClass >> initializeClassVars [
	| dictionary |
	dictionary := (self classVars
		asRemoteObjectInObjectSpace: self objectSpace) asRemoteDictionary.
	self testStub.
	self remote classVars: dictionary.
	self testStub.
	^ dictionary
]

{ #category : #initialization }
CandleClass >> initializeWithTemplateCustom: aTemplateClass [
	
	self instVarsNames: aTemplateClass instVarNames.
	self classVars: #().
	self parent ensureClassNamed: self name, self parent metaclassSuffix.
	self metaclass initializeWithSoleInstance: self.
	
	^ self
]

{ #category : #hooks }
CandleClass >> innerBindingOf: aSymbol [

	"First look in classVar dictionary."
	(self classVars bindingOf: aSymbol) ifNotNil: [ 
		^ self remote classVars asRemoteDictionary bindingOf: aSymbol ].

	self superclass
		ifNotNil: [ :supercl | ^ supercl innerBindingOf: aSymbol ].
	^ nil
]

{ #category : #accessing }
CandleClass >> instVarsNames [
	^ instVarsNames
]

{ #category : #accessing }
CandleClass >> instVarsNames: anObject [
	instVarsNames := anObject
]

{ #category : #'class stub' }
CandleClass >> installMetaclassStub [
		"I install a class stub that is instance of itself"
	| newMetaclassclass newMetaclass metaclassclassIndex metaclassIndex |
	self deprecated: 'Use LanguageModel >> installMulticlassStubs:'.
	" If the metaclass was already created, it will be found in the bootstrapEnvironment dictionary "
	self remoteIsInstalled
		ifTrue: [ ^ self remote ].

	" We need to create the metaclass from scratch "
	metaclassclassIndex := self classLoader newClassIndex.
	metaclassIndex := self classLoader newClassIndex.
	
	newMetaclassclass := self classLoader
		createStubForClassNamed: self metaclass name
		metaclassIndex: metaclassIndex 
		newClassIndex: metaclassclassIndex.
	
	newMetaclass := self classLoader
		createStubForClassNamed: self name
		metaclassIndex: metaclassclassIndex
		newClassIndex: metaclassIndex.
	
	self assert: newMetaclassclass basicClass = newMetaclass.
	self assert: newMetaclassclass classTableIndex = metaclassclassIndex .
	
	self assert: newMetaclass basicClass = newMetaclassclass.
	self assert: newMetaclass classTableIndex = metaclassIndex .
	
	self metaclass remote ifNil: [ 
		self metaclass remote: newMetaclassclass .
		self classLoader
			registerClass: newMetaclassclass
			definition: self metaclass
			fullyLoaded: false. 
		].
	^ newMetaclass
]

{ #category : #testing }
CandleClass >> isCandleClass [
	^ true
]

{ #category : #testing }
CandleClass >> isCandleMetaclass [
	^ false
]

{ #category : #accessing }
CandleClass >> metaclass [
	^ self parent ensureClassNamed: self name , self parent metaclassSuffix
]

{ #category : #accessing }
CandleClass >> name [
	^ name
]

{ #category : #accessing }
CandleClass >> name: anObject [
	super name: anObject.
	name := anObject
]

{ #category : #accessing }
CandleClass >> test [ 
	super test.
	self assert: self metaclass isNotNil.
	self assert: self name isNotNil.
	self assert: self name = self name.
	self assert: (self parent isValidMetaclassName: self name) not
"	self assert: self classVariables1 isArray.
	self assert: self instVarNames1 isNotNil.
	self assert: self instVarNames1 isArray"
]
