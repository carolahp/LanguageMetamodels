"
I am the metamodel of the ObjVLisp language definition.
I require the PharoBootstrapGeneric and its dependencies.

The last entry point to test was:
'
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

{ #category : #'hooks-api' }
ObjVLispLanguage class >> globalVariableMetaclass [

	^ ObjVLispGlobal 
]

{ #category : #hooks }
ObjVLispLanguage >> createInitialObjects [
	^ nil
]

{ #category : #hooks }
ObjVLispLanguage >> createRemoteSystemDictionary [
	| code |

	code := '
		Smalltalk instVarAt: 1 put: SystemDictionary new.
		Smalltalk globals at: #Smalltalk put: Smalltalk.
		Smalltalk globals'.
	^ (self newInstruction code: code) evaluate
]

{ #category : #hooks }
ObjVLispLanguage >> initializeSpecialObjectsArray [
	^ nil
]

{ #category : #hooks }
ObjVLispLanguage >> loadGlobalVariables [
	self globalVariables
		add:
			((self class globalVariableMetaclass named: #Smalltalk parent: self)
				role: #Smalltalk;
				initializationCode: 'SmalltalkImage basicNew')
]
