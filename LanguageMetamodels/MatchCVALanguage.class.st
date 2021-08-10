Class {
	#name : #MatchCVALanguage,
	#superclass : #MatchLanguage,
	#category : #'LanguageMetamodels-MatchCVAspects'
}

{ #category : #metamodel }
MatchCVALanguage class >> classModel [
	^ MatchCVAClass
]

{ #category : #metamodel }
MatchCVALanguage class >> customModels [
	^ { MatchCVAMetaclass }
]

{ #category : #metamodel }
MatchCVALanguage class >> metaclassModel [
	^ MatchCVAMetaclass
]

{ #category : #roles }
MatchCVALanguage >> transform [ 
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
