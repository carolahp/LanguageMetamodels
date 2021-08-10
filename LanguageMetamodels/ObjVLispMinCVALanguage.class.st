Class {
	#name : #ObjVLispMinCVALanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispMinCVAspects'
}

{ #category : #'hooks-api' }
ObjVLispMinCVALanguage class >> classModel [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispMinCVAClass  
]

{ #category : #hooks }
ObjVLispMinCVALanguage >> transform [ 
	"| dog dogClassPool |
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
	dog classPool: dogClassPool"
]
