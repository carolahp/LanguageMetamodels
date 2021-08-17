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
