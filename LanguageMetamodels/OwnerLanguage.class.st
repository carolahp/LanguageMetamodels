"
Download my Language Definitions from https://github.com/carolahp/PharoCandleSrc/tree/ownerlanguage
and set them in the constructor 
OwnerLanguage 
	newFromModel: pathToDefinitions 
	withName: #Owner
	withEntryPoint: 'PCSystem log: ''hello from Owner!''. PCSystem quit'.
"
Class {
	#name : #OwnerLanguage,
	#superclass : #CandleLanguage,
	#category : #'LanguageMetamodels-Owner'
}

{ #category : #'hooks-api' }
OwnerLanguage class >> classModel [
	^ OwnerClass
]

{ #category : #'hooks-api' }
OwnerLanguage class >> globalModel [
	^ OwnerGlobal
]

{ #category : #'hooks-api' }
OwnerLanguage class >> metaclassModel [
	^ OwnerMetaclass
]

{ #category : #'hooks-api' }
OwnerLanguage class >> methodModel [
	^OwnerMethod
]

{ #category : #hooks }
OwnerLanguage >> createInitialObjects [
	super createInitialObjects.
	(self classNamed: #PCString) ensureRemote classVars asRemoteDictionary
		at: #AsciiOrder 
		put: ((0 to: 255) as: ByteArray)
]

{ #category : #hooks }
OwnerLanguage >> createRemoteSystemDictionary [
	| dictionary smalltalk |
	smalltalk := (self globalVariableNamed: #Smalltalk) remote.
	dictionary := (EP2RemoteSystemDictionary
		newWithBackend: self remote backend
		size: 50).
	dictionary at: #Smalltalk put: smalltalk.
	smalltalk instanceVariableAtIndex: 1 put: dictionary.
	^ dictionary
]

{ #category : #install }
OwnerLanguage >> customClassRoles [
	^ super customClassRoles asOrderedCollection
		add: #IdentityDictionary -> #PCIdentityDictionary;
		yourself
]

{ #category : #install }
OwnerLanguage >> myRemoteSystemDictionary [
	^ ((self globalVariableNamed: #Smalltalk) remote
		instanceVariableAtIndex: 1) asRemoteSystemDictionary 
]

{ #category : #hooks }
OwnerLanguage >> transform [
	self test.
	"add inst var owner where possible"
	(self classWithRole: #ProtoObject)
		addSlotRecursivelyWherePossible: #owner.
	self test.
	self allClasses
		do: [ :class | 
			| getSrc setSrc |
			getSrc := 'owner ^ owner'.
			setSrc := 'owner:object owner:=object'.
			"special methods if owner does not exist"
			class
				slotNamed: #owner
				ifAbsent: [ getSrc := 'owner ^ self class instancesDict at: self basicIdentityHash'.
					setSrc := 'owner:object self class instancesDict at: self basicIdentityHash put: object' ].
			class addLocalMethodFromSource: getSrc selector: #owner.
			class addLocalMethodFromSource: setSrc selector: #owner:. ]
]
