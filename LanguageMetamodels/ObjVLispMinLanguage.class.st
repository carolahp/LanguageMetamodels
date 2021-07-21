"
Language Definitions found in https://github.com/carolahp/KernelExplicitMetaclasses/tree/minimum

""instantiate the language model""
language := (ObjVLispMinLanguage 
newFromModel: '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMinLiterals' asFileReference 
withName:  'ObjVLispMin'  
withEntryPoint: '
	| holi |
	holi := 1.
	System log: ''hello world''.
	System log: ''hello world'' identityHash asString.
   
	System quit.').
language generate.
language writeImage.
language imageInDisk executeInVM.

language imageInDisk executeInVMSimulator.
language browse.
"
Class {
	#name : #ObjVLispMinLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-ObjVLispMin'
}

{ #category : #'hooks-api' }
ObjVLispMinLanguage class >> globalModel [
	^ ObjVLispMinGlobal 
]

{ #category : #'hooks-api' }
ObjVLispMinLanguage class >> metaclassModel [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispMinClass  
]

{ #category : #'hooks-api' }
ObjVLispMinLanguage class >> packageModel [
	^ PackageModel
]

{ #category : #hooks }
ObjVLispMinLanguage >> createInitialObjects [
	"perform operations to initialize Classes classPools, or instructinos such as String initialize"
	^ nil
]

{ #category : #hooks }
ObjVLispMinLanguage >> createRemoteSystemDictionary [
	" return a new SystemDictionary instance, or nil if your language does not define a system dictionary"
	^ nil
]

{ #category : #roles }
ObjVLispMinLanguage >> customClassRoles [
	^ nil
]

{ #category : #hooks }
ObjVLispMinLanguage >> firstMetaclasses [
	^{self classWithRole: #Metaclass}
]

{ #category : #hooks }
ObjVLispMinLanguage >> initializeSpecialObjectsArray [
	^ nil
]

{ #category : #'building-class-model' }
ObjVLispMinLanguage >> loadGlobalVariables [
	" no globals in objvlisp min"
]

{ #category : #hooks }
ObjVLispMinLanguage >> transform [ 
	^ self
]
