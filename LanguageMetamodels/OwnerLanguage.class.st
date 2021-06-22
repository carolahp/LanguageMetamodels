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
OwnerLanguage class >> classMetaclass [
	^ OwnerMetaclass
]

{ #category : #'hooks-api' }
OwnerLanguage class >> globalVariableMetaclass [
	^ OwnerGlobal
]

{ #category : #hooks }
OwnerLanguage >> test [ 

	super test.
	1halt.
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
			| srcGet srcSet |
			class
				slotNamed: #owner
				ifAbsent: [ srcGet := 'owner ^ owner'.
					srcSet := 'owner:object owner:=object' ]
				ifPresent: [ srcGet := 'owner ^ nil'.
					srcSet := 'owner:object owner:=nil' ] ]
]
