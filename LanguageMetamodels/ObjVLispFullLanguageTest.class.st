Class {
	#name : #ObjVLispFullLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
ObjVLispFullLanguageTest >> languageModelClass [
	^ ObjVLispLanguage
]

{ #category : #'instance creation' }
ObjVLispFullLanguageTest >> sourcesPath [
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
ObjVLispFullLanguageTest >> testLoadSourceFiles [
	entryPointCode := 'System quit'.
	self newModel
]
