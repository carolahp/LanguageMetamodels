Class {
	#name : #ObjVLispDynLanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
ObjVLispDynLanguage class >> tempVariableModel [
	 ^ DynamicVariableModel 
]
