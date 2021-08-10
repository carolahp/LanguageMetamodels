Class {
	#name : #ObjVLispDynClass,
	#superclass : #ObjVLispMinClass,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #'hooks-api' }
ObjVLispDynClass class >> methodModel [
	^ ObjVLispDynMethod
]

{ #category : #install }
ObjVLispDynClass >> installCustom [
	super installCustom
	"self remote
		name: self name"
]
