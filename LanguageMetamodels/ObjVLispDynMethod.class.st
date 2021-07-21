Class {
	#name : #ObjVLispDynMethod,
	#superclass : #MethodModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #hooks }
ObjVLispDynMethod >> installCustom [
	^ remote
]
