Class {
	#name : #ObjVLispDynUndeclaredVariable,
	#superclass : #UndeclaredVariableModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #'instance creation' }
ObjVLispDynUndeclaredVariable class >> newFrom: aRBVariableNode inContext: anEP2CompilationContext withAnalyzer: anEP2SemanticAnalyzer [
	| model node context analyzer |
	node := aRBVariableNode.
	context := anEP2CompilationContext.
	analyzer := anEP2SemanticAnalyzer.
	(node methodOrBlockNode isNil "this happens with pragma variables"
	or: [ node methodOrBlockNode isBlock ]) "this happens with blocks"
		ifTrue:
			[ ^ super newFrom: node inContext: context withAnalyzer: analyzer ].
	model := (context getClass methodDict at: node methodNode selector)
		class tempVariableModel
		newFrom: node
		inContext: context.
	^ analyzer declareVariableNode: node as: model
]
