Class {
	#name : #ObjVLispMinLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-ObjVLispMin'
}

{ #category : #'hooks-api' }
ObjVLispMinLanguage class >> classMetaclass [
	" Return the subclass of EP2MClass that defines the metamodel for classes of the language "
	^ ObjVLispMinClass  
]
