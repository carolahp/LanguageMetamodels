Class {
	#name : #ObjVLispNSPackage,
	#superclass : #PackageModel,
	#instVars : [
		'name',
		'classesDict'
	],
	#category : #'LanguageMetamodels-ObjVLispNamespaces'
}

{ #category : #instanciation }
ObjVLispNSPackage class >> allModelInstVarNames [ 
	^ self allInstVarNames difference: PackageModel allInstVarNames
]

{ #category : #instanciation }
ObjVLispNSPackage class >> defaultLayout [
	^ EP2FixedLayout 
]

{ #category : #registering }
ObjVLispNSPackage >> asRemoteObjectInObjectSpace: anObjectSpace [
	super asRemoteObjectInObjectSpace: anObjectSpace.
	self register.
	^ self remote
]

{ #category : #registering }
ObjVLispNSPackage >> at: aString ifAbsent: aBlock [
	^ self environment at: aString ifAbsent: aBlock

]

{ #category : #accessing }
ObjVLispNSPackage >> bindingOf: aSymbol [
	| result |
	result := self
		classNamed: aSymbol
		ifAbsent: [ nil ]
		ifPresent: [ :classModel | classModel ensureRemote ].
	result := result
		ifNil: [ (self environment bindingOf: aSymbol) ifNil: [ ^ nil ] ].
	^ self environment newGlobalBindingFor: aSymbol
]

{ #category : #accessing }
ObjVLispNSPackage >> classNamed: aSymbol ifAbsent: aBlockClosure [ 
	^ [self classesDict at: aSymbol asSymbol] on: KeyNotFound do: [ nil ]
]

{ #category : #accessing }
ObjVLispNSPackage >> classesDict [
	^ classesDict := (definedBehaviors
		collect: [ :class | class shortName -> class ]) asDictionary
]

{ #category : #registering }
ObjVLispNSPackage >> registerCustom [
	self remoteSystemDictionary at: self name put: self remote
]

{ #category : #registering }
ObjVLispNSPackage >> remoteSystemDictionary [
	^ self parent remote espellBackend objectSpace systemDictionary
]
