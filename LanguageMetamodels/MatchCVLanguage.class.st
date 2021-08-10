Class {
	#name : #MatchCVLanguage,
	#superclass : #MatchLanguage,
	#category : #'LanguageMetamodels-Match'
}

{ #category : #'hooks-api' }
MatchCVLanguage class >> classModel [
	^ MatchCVClass
]

{ #category : #'hooks-api' }
MatchCVLanguage class >> customModels [
	^ { MatchCVMetaclass }
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
	dogClassPool := {((ClassVariableModel named: #Kingdom parent: dog)
		initializationCode: '#animal')} asDictionary.
	dog classPool: dogClassPool
]
