Class {
	#name : #CandleNSClass,
	#superclass : #CandleClass,
	#instVars : [
		'package'
	],
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

{ #category : #binding }
CandleNSClass >> = aCandleNSClass [
	(aCandleNSClass class == self class) ifFalse: [ ^ false ].
	^ self fullName = aCandleNSClass fullName
]

{ #category : #binding }
CandleNSClass >> binding [
	^ self environment environment newGlobalBindingFor: self name asSymbol
]

{ #category : #binding }
CandleNSClass >> bindingOf: varName [
	| aSymbol |
	aSymbol := varName asSymbol.
	^ (self innerBindingOf: aSymbol) ifNil: [
		self package bindingOf: aSymbol
	]
]

{ #category : #binding }
CandleNSClass >> environment [ 
	^ self package
]

{ #category : #hooks }
CandleNSClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [
	package := self parent ensurePackageNamed: anEP2MCClassDefinition category.
	package addDefinedBehavior: self.
	super extendWithMonticelloCustom: anEP2MCClassDefinition.
	^ self
]

{ #category : #binding }
CandleNSClass >> fullName [
	^ self package name, '>', name
]

{ #category : #binding }
CandleNSClass >> installCustom [
	self remote
		name: self name;
		instVarsNames: self instVarsNames;
		package: self remotePackage.
	(self remotePackage instanceVariableAtIndex: 2) asRemoteDictionary
		at: self name
		put: self remote.
	self remote classVars ifNilObject: [ self initializeClassVars ]
]

{ #category : #binding }
CandleNSClass >> name [
	^ name 
]

{ #category : #binding }
CandleNSClass >> name: aString [
	name := (aString asString copyReplaceAll: 'Kernel>' with: '') asSymbol. 
	super name: name
]

{ #category : #binding }
CandleNSClass >> package [ 
	^ package ifNil: [ 
		self package: self parent defaultPackage.
		self package ]
]

{ #category : #binding }
CandleNSClass >> package: aCandleNSPackage [
	package ifNotNil: [ package removeDefinedBehavior: self ].
	package := aCandleNSPackage.
	package addDefinedBehavior: self
]

{ #category : #binding }
CandleNSClass >> remotePackage [
	^ self package ensureRemote.
]
