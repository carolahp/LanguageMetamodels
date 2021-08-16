Class {
	#name : #CandleNSClass,
	#superclass : #CandleClass,
	#instVars : [
		'package'
	],
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

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

{ #category : #binding }
CandleNSClass >> fullName [
	^ self package name, '>', self name
]

{ #category : #binding }
CandleNSClass >> initialize [
	"force classes to have a package"
	self package.
	super initialize.
	
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
CandleNSClass >> remotePackage [
	^ self package ensureRemote.
]
