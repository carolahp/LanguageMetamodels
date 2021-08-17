Class {
	#name : #CandleNSPackage,
	#superclass : #PackageModel,
	#category : #'LanguageMetamodels-CandleNameSpaces'
}

{ #category : #exporting }
CandleNSPackage >> asMCSnapshot [
	| definitions |
	definitions := #() asOrderedCollection.
	"adding the package"
	definitions add: self asMCDefinition.
	"adding behaviors"
	definitions
		addAll:
			(((self definedBehaviors reject: #isCandleMetaclass)
				sorted: [ :a :b | a name < b name ]) collect: #asMCDefinition).
	"adding methods"
	
	definitions
		addAll:
			(self definedBehaviors , (self definedBehaviors collect: #metaclass)
				flatCollect: [ :behavior | 
					(behavior localMethods
						reject: [ :each | (each parent tonelInstanceSide package = each package) not ])
						collect: [ :method | method asMCDefinition ] ]).
	^ MCSnapshot fromDefinitions: definitions
]

{ #category : #installing }
CandleNSPackage >> asRemoteObjectInObjectSpace: anObjectSpace [
	^ self ensureRemote
]

{ #category : #binding }
CandleNSPackage >> at: aString ifAbsent: aBlockClosure [
	^ self environment at: aString ifAbsent: aBlockClosure
]

{ #category : #binding }
CandleNSPackage >> bindingOf: aSymbol [
	| result |
	result := self
		classNamed: aSymbol
		ifAbsent: [ nil ]
		ifPresent: [ :classModel | classModel ensureRemote ].
	result := result
		ifNil: [ (self environment bindingOf: aSymbol) ifNil: [ ^ nil ] ].
	^ self environment newGlobalBindingFor: aSymbol
]

{ #category : #installing }
CandleNSPackage >> ensureRemote [

	^ (self remote
		ifNil:
			[ " I have not been installed yet."
			self install.
			self remote ])
]

{ #category : #installing }
CandleNSPackage >> install [
	| remotePackageClass remoteClassesDict remoteName |
	remote ifNotNil: [ ^ remote ].
	
	remotePackageClass := (self parent classNamed: 'PCPackage') ensureRemote.
	remote := remotePackageClass basicNew.
	remoteName := self name asString asRemoteObjectInObjectSpace: self parent objectSpace.
	remoteClassesDict := (Dictionary new
		asRemoteObjectInObjectSpace: self parent objectSpace) asRemoteDictionary.
	
	remote instanceVariableAtIndex: 1 put: remoteName.
	remote instanceVariableAtIndex: 2 put: remoteClassesDict.
	self register.
	^ remote
]

{ #category : #installing }
CandleNSPackage >> installAccessedObjectsOnly [
	^ self environment installAccessedObjectsOnly 
]

{ #category : #registering }
CandleNSPackage >> registerCustom [
	^ ((self parent globalVariableNamed: #Smalltalk) remote
		instanceVariableAtIndex: 1) asRemoteDictionary
		at: self name asSymbol
		put: self remote
]
