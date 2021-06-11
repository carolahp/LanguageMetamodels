Class {
	#name : #ObjVLispGlobal,
	#superclass : #GlobalModel,
	#category : #'LanguageMetamodels-ObjVLisp'
}

{ #category : #registering }
ObjVLispGlobal >> hookRegister [
	| temps code |
	temps := {(#name -> self name) . (#value -> self remote)}.
	code := 'Smalltalk globals at: name put: value'.
	self newInstruction
		code: code;
		temps: temps;
		evaluate
]
