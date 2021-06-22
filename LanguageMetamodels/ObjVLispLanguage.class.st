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

{ #category : #'hooks-api' }
ObjVLispLanguage class >> globalModel [

	^ ObjVLispGlobal 
]

{ #category : #'as yet unclassified' }
ObjVLispLanguage class >> metaclassModel [
	^ ObjVLispClass
]

{ #category : #'hooks-api' }
ObjVLispLanguage class >> packageModel [
	^ PackageModel
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

{ #category : #roles }
ObjVLispLanguage >> customClassRoles [
	" roles are specified in default language model in tonel repo"
	^ nil
]

{ #category : #hooks }
ObjVLispLanguage >> initializeSpecialObjectsArray [
	| code temps |
	temps := { 'soa' -> self objectSpace specialObjectsArray }.
	code := 'Smalltalk specialObjectsArray: soa '.
	
	^ (self newInstruction code: code; temps: temps; yourself) evaluate.
]

{ #category : #hooks }
ObjVLispLanguage >> loadGlobalVariables [
	self globalVariables
		add:
			((self class globalModel named: #Smalltalk parent: self)
				role: #Smalltalk;
				initializationCode: 'SmalltalkImage basicNew')
]

{ #category : #hooks }
ObjVLispLanguage >> transform [ 
	^ self
]
