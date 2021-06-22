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
OwnerLanguage >> transform [
	self test.
	
	(self classWithRole: #ProtoObject) addSlotRecursivelyWherePossible: #owner.
	self test.
	self halt.
	self allClasses select: [ :class | (class slotNamed: #owner ifAbsent: [ nil ]) isNil ].
]
