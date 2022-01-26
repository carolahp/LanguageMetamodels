Class {
	#name : #ObjVLispDynMethod,
	#superclass : #MethodModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #metamodel }
ObjVLispDynMethod class >> tempVariableModel [
	^ DynamicVariableModel
]

{ #category : #hooks }
ObjVLispDynMethod >> installCustom [
	^ remote
]
