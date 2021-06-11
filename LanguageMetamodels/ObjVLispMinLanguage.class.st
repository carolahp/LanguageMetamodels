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

{ #category : #'building-class-model' }
ObjVLispMinLanguage >> loadClasses [
	self
		loadLanguageModelDefinitions:
			Smalltalk imageDirectory
				/ 'bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'building-class-model' }
ObjVLispMinLanguage >> loadGlobalVariables [
	" no globals in objvlisp min"
]
