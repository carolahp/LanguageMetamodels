Class {
	#name : #ObjVLispDynClass,
	#superclass : #ObjVLispMinClass,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #'hooks-api' }
ObjVLispDynClass class >> methodModel [
	^ ObjVLispDynMethod
]
