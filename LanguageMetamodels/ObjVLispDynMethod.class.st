Class {
	#name : #ObjVLispDynMethod,
	#superclass : #MethodModel,
	#category : #'LanguageMetamodels-ObjVLispDyn'
}

{ #category : #hooks }
ObjVLispDynMethod >> installCustom [
]

{ #category : #hooks }
ObjVLispDynMethod >> localCompiledMethodFromAST: aRBMethodNode [
	| temporaries ir |
	temporaries := aRBMethodNode temporaries collect: #name.
	ir := 	EP2IRMethod newFrom: aRBMethodNode generateIR.
	^ ir compiledMethodWith: CompiledMethodTrailer empty model: self.
]
