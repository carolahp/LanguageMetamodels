"
I am the metamodel of the ObjVLisp language definition.
I require the PharoBootstrapGeneric and its dependencies.


"
Class {
	#name : #ObjVLispLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-ObjVLisp'
}

{ #category : #'as yet unclassified' }
ObjVLispLanguage class >> classMetaclass [
	^ ObjVLispClass
]

{ #category : #hooks }
ObjVLispLanguage >> entryPointCode [
	^ '
	| p |
	p := Point new.
	System log: ''before garbage collection''.
	System garbageCollect.
	System log: ''after garbage collection''.
	p setPinnedInMemory: true. 
	System log: ''after pinning object collection''.
	System garbageCollect.
	System log: ''after pinning and garbage collection''.
	System snapshotAndQuit'
]

{ #category : #hooks }
ObjVLispLanguage >> hookInitializeSpecialObjectsArray [
	^ nil
]
