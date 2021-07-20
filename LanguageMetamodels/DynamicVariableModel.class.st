Class {
	#name : #DynamicVariableModel,
	#superclass : #TempVariableModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #'accessing-api' }
DynamicVariableModel >> emitStore: methodBuilder [
	self halt
]

{ #category : #'accessing-api' }
DynamicVariableModel >> emitValue: methodBuilder [

	self halt.
]
