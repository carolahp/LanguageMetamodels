"
Match language with class variables
"
Class {
	#name : #MatchCVLanguage,
	#superclass : #MatchLanguage,
	#category : #'LanguageMetamodels-MatchCV'
}

{ #category : #'hooks-api' }
MatchCVLanguage class >> classModel [
	^ MatchCVClass
]

{ #category : #'hooks-api' }
MatchCVLanguage class >> customFirstClassModels [
	^ { self metaclassModel }
]

{ #category : #'hooks-api' }
MatchCVLanguage class >> metaclassModel [
	^ MatchCVMetaclass
]

{ #category : #roles }
MatchCVLanguage >> transform [
	| dog dogClassPool |
	super transform.
	dog := self ensureClassNamed: 'Dog'.
	dog
		addLocalMethodFromSource:
			'kingdom 
			^ Kingdom'
		selector: #kingdom.
	dog
		addLocalMethodFromSource:
			'kingdom: aString 
			Kingdom := aString'
		selector: #kingdom:.
	dog metaclass
		addLocalMethodFromSource:
			'kingdom 
			^ Kingdom'
		selector: #kingdom.
	dog metaclass
		addLocalMethodFromSource:
			'kingdom: aString 
			Kingdom := aString'
		selector: #kingdom:.
	dogClassPool := {((ClassVariableModel named: #Kingdom parent: dog)
		initializationCode: '#animal')} asDictionary.
	"dogClassPool := {(#Kingdom -> #animal)} asDictionary."
	dog classPool: dogClassPool
]
