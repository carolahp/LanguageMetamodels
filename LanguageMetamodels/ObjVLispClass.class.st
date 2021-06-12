"
I am the metamodel of a class in ObjVLisp.
"
Class {
	#name : #ObjVLispClass,
	#superclass : #ExplicitMetaclassesAugmentedClass,
	#category : #'LanguageMetamodels-ObjVLisp'
}

{ #category : #'accessing remote backend' }
ObjVLispClass >> ensureRemote [
	^ self remote
		ifNil:
			[ " I have not been installed yet."
			self installStub.
			self remote ]
]
