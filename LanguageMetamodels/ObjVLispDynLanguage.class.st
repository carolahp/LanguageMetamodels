Class {
	#name : #ObjVLispDynLanguage,
	#superclass : #ObjVLispMinLanguage,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
ObjVLispDynLanguage class >> metaclassModel [
	" Return the subclass of ClassModel that defines the metamodel for classes of the language "
	^ ObjVLispDynClass 
]

{ #category : #metamodel }
ObjVLispDynLanguage class >> tempVariableModel [
	 "^ DynamicVariableModel "
	^ TempVariableModel
]
