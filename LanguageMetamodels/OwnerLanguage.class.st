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

{ #category : #hooks }
OwnerLanguage >> transform [
	self test.
	"add inst var owner where possible"
	(self classWithRole: #ProtoObject)
		addSlotRecursivelyWherePossible: #owner.
	self test.
	self allClasses
		do: [ :class | 
			| getSrc setSrc getter setter |
			getSrc := 'owner ^ owner'.
			setSrc := 'owner:object owner:=object'.
			"special methods if owner does not exist"
			class
				slotNamed: #owner
				ifAbsent: [ getSrc := 'owner ^ nil'.
					setSrc := 'owner:object ^self' ].
			class addLocalMethodFromSource: getSrc selector: #owner.
			class addLocalMethodFromSource: setSrc selector: #owner:. ]
]
